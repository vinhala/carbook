import 'dart:async';

import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/data/local/drift_assistant_repository.dart';
import 'package:carful/src/data/local/drift_workshop_manual_repository.dart';
import 'package:carful/src/domain/assistant_message.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/domain/workshop_manual_input.dart';
import 'package:carful/src/services/ai_backend_service.dart';
import 'package:carful/src/services/media_service.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../support/test_app.dart';
import '../support/test_doubles.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository repository;
  late DriftMaintenanceRepository maintenanceRepository;
  late DriftWorkshopManualRepository workshopManualRepository;
  late DriftAssistantRepository assistantRepository;
  late FakeMediaService mediaService;
  late FakeAiBackendService aiBackendService;
  late RecordingReminderScheduler reminderScheduler;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftCarProfileRepository(database);
    maintenanceRepository = DriftMaintenanceRepository(database);
    workshopManualRepository = DriftWorkshopManualRepository(database);
    assistantRepository = DriftAssistantRepository(database);
    mediaService = FakeMediaService();
    aiBackendService = FakeAiBackendService();
    reminderScheduler = RecordingReminderScheduler();
  });

  tearDown(() async {
    await database.close();
  });

  Future<int> createProfile() {
    return repository.createProfile(
      CarProfileInput(
        make: 'Toyota',
        model: 'Tacoma',
        engine: '3.5L V6',
        firstRegistrationMonth: DateTime(2018, 5),
        vin: 'JT1234567890',
        currentMileage: 6500,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.monthly,
      ),
    );
  }

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestApp(
        database: database,
        repository: repository,
        maintenanceRepository: maintenanceRepository,
        workshopManualRepository: workshopManualRepository,
        assistantRepository: assistantRepository,
        aiBackendService: aiBackendService,
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('disables AI assistant entry point until manuals exist', (
    tester,
  ) async {
    final carId = await createProfile();
    await pumpApp(tester);
    await tester.tap(find.text('Toyota Tacoma'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('add-manual-button')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.byKey(const ValueKey('add-manual-button')));
    await tester.tap(
      find.byKey(const ValueKey('add-manual-button')),
      warnIfMissed: false,
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('add-manual-button')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('open-ai-assistant-button')),
      findsOneWidget,
    );
    expect(
      find.text(
        'Add at least one workshop manual to start using the assistant.',
      ),
      findsOneWidget,
    );
    var button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('open-ai-assistant-button')),
    );
    expect(button.onPressed, isNull);

    await workshopManualRepository.createManual(
      carId,
      const WorkshopManualInput(
        backendManualId: 'manual_1',
        localPath: '/stored/manual.pdf',
        originalName: 'Tacoma Manual.pdf',
        byteSize: 2048,
      ),
    );

    await tester.pumpAndSettle();
    button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('open-ai-assistant-button')),
    );
    expect(button.onPressed, isNotNull);
    await _disposeApp(tester);
  });

  testWidgets('shows a disabled loading state while adding a workshop manual', (
    tester,
  ) async {
    await createProfile();
    mediaService.nextPickedWorkshopManuals = const [
      PickedDocumentFile(
        path: '/tmp/tacoma_manual.pdf',
        originalName: 'Tacoma Manual.pdf',
        byteSize: 2048,
      ),
    ];
    final uploadCompleter = Completer<void>();
    addTearDown(() {
      if (!uploadCompleter.isCompleted) {
        uploadCompleter.complete();
      }
    });
    aiBackendService.manualUploadBlocker = uploadCompleter.future;

    await pumpApp(tester);
    await tester.tap(find.text('Toyota Tacoma'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('add-manual-button')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.byKey(const ValueKey('add-manual-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add manual'));
    await tester.pump();
    await tester.pump();

    var button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('add-manual-button')),
    );
    expect(button.onPressed, isNull);
    expect(find.text('Adding...'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('add-manual-button')),
        matching: find.byType(CircularProgressIndicator),
      ),
      findsOneWidget,
    );

    uploadCompleter.complete();
    await tester.pumpAndSettle();

    button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('add-manual-button')),
    );
    expect(button.onPressed, isNotNull);
    expect(find.text('Add manual'), findsOneWidget);
    expect(aiBackendService.uploadedFiles, hasLength(1));
    await _disposeApp(tester);
  });

  testWidgets('disables AI schedule generation until manuals exist', (
    tester,
  ) async {
    final carId = await createProfile();

    await pumpApp(tester);
    await tester.tap(find.text('Toyota Tacoma'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Maintenance schedule'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Open').first);
    await tester.pumpAndSettle();

    var button = tester.widget<IconButton>(
      find.byKey(const ValueKey('open-ai-schedule-generator-button')),
    );
    expect(button.onPressed, isNull);

    await workshopManualRepository.createManual(
      carId,
      const WorkshopManualInput(
        backendManualId: 'manual_1',
        localPath: '/stored/manual.pdf',
        originalName: 'Tacoma Manual.pdf',
        byteSize: 2048,
      ),
    );

    await tester.pumpAndSettle();
    button = tester.widget<IconButton>(
      find.byKey(const ValueKey('open-ai-schedule-generator-button')),
    );
    expect(button.onPressed, isNotNull);
    await _disposeApp(tester);
  });

  testWidgets('renders the guardrail response for rejected AI chat messages', (
    tester,
  ) async {
    final carId = await createProfile();
    await workshopManualRepository.createManual(
      carId,
      const WorkshopManualInput(
        backendManualId: 'manual_1',
        localPath: '/stored/manual.pdf',
        originalName: 'Tacoma Manual.pdf',
        byteSize: 2048,
      ),
    );
    await assistantRepository.addMessage(
      carProfileId: carId,
      role: AssistantMessageRole.user,
      content: 'How do I make lasagna?',
    );
    await assistantRepository.addMessage(
      carProfileId: carId,
      role: AssistantMessageRole.assistant,
      content:
          'Carful AI can only answer questions about this vehicle and its maintenance, repairs, manuals, or troubleshooting.',
      rejectionReasonCode: 'unrelated_topic',
    );

    await pumpApp(tester);
    GoRouter.of(
      tester.element(find.byType(Scaffold).first),
    ).go('/cars/$carId/assistant');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('How do I make lasagna?'), findsOneWidget);
    final messages = await assistantRepository.listMessages(carId);
    expect(messages, hasLength(2));
    expect(messages.last.rejectionReasonCode, 'unrelated_topic');
    expect(
      messages.last.content,
      contains('Carful AI can only answer questions about this vehicle'),
    );
    await _disposeApp(tester);
  });

  testWidgets('shows disabled AI assistant state when opened without manuals', (
    tester,
  ) async {
    final carId = await createProfile();

    await pumpApp(tester);
    GoRouter.of(
      tester.element(find.byType(Scaffold).first),
    ).go('/cars/$carId/assistant');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.text(
        'Add at least one workshop manual to start using the assistant.',
      ),
      findsWidgets,
    );
    expect(find.byKey(const ValueKey('assistant-message-field')), findsNothing);
    expect(find.byKey(const ValueKey('assistant-send-button')), findsNothing);
    await _disposeApp(tester);
  });

  testWidgets('shows AI assistant composer when manuals exist', (tester) async {
    final carId = await createProfile();
    await workshopManualRepository.createManual(
      carId,
      const WorkshopManualInput(
        backendManualId: 'manual_1',
        localPath: '/stored/manual.pdf',
        originalName: 'Tacoma Manual.pdf',
        byteSize: 2048,
      ),
    );

    await pumpApp(tester);
    GoRouter.of(
      tester.element(find.byType(Scaffold).first),
    ).go('/cars/$carId/assistant');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.byKey(const ValueKey('assistant-message-field')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('assistant-send-button')), findsOneWidget);
    await _disposeApp(tester);
  });
}

Future<void> _disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1));
}
