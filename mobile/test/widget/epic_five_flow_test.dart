import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/data/local/drift_assistant_repository.dart';
import 'package:carbook/src/data/local/drift_workshop_manual_repository.dart';
import 'package:carbook/src/domain/car_profile_input.dart';
import 'package:carbook/src/domain/mileage_reminder_frequency.dart';
import 'package:carbook/src/domain/workshop_manual_input.dart';
import 'package:carbook/src/features/ai/ai_assistant_controller.dart';
import 'package:carbook/src/services/ai_backend_service.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  testWidgets('shows the Epic 5 workshop manual and AI entry points', (
    tester,
  ) async {
    await createProfile();
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

    var button = tester.widget<FilledButton>(
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
    button = tester.widget<FilledButton>(
      find.byKey(const ValueKey('open-ai-schedule-generator-button')),
    );
    expect(button.onPressed, isNotNull);
    await _disposeApp(tester);
  });

  testWidgets('renders the guardrail response for rejected AI chat messages', (
    tester,
  ) async {
    final carId = await createProfile();
    aiBackendService.nextAssistantResponse = const AssistantBackendResponse(
      status: 'rejected',
      conversationId: 'conv_guardrail',
      messageId: 'msg_guardrail',
      content:
          'Carbook AI can only answer questions about this vehicle and its maintenance, repairs, manuals, or troubleshooting.',
      sources: [],
      rejectionReasonCode: 'unrelated_topic',
      usedWebSearch: false,
      usedFileSearch: false,
    );

    await pumpApp(tester);
    await tester.tap(find.text('Toyota Tacoma'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('open-ai-assistant-button')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const ValueKey('open-ai-assistant-button')));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(Scaffold).first),
    );
    await container
        .read(aiAssistantControllerProvider)
        .sendMessage(carId, 'How do I make lasagna?');
    await tester.pumpAndSettle();

    expect(find.text('How do I make lasagna?'), findsOneWidget);
    expect(aiBackendService.sentMessages, ['How do I make lasagna?']);
    final messages = await assistantRepository.listMessages(carId);
    expect(messages, hasLength(2));
    expect(messages.last.rejectionReasonCode, 'unrelated_topic');
    expect(
      messages.last.content,
      contains('Carbook AI can only answer questions about this vehicle'),
    );
    await _disposeApp(tester);
  });
}

Future<void> _disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1));
}
