import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/domain/repair_area.dart';
import 'package:carful/src/domain/repair_attachment_kind.dart';
import 'package:carful/src/domain/repair_entry_input.dart';
import 'package:carful/src/domain/repair_part_input.dart';
import 'package:carful/src/domain/repair_status.dart';
import 'package:carful/src/domain/repair_urgency.dart';
import 'package:carful/src/services/media_service.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';
import '../support/test_doubles.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository repository;
  late DriftMaintenanceRepository maintenanceRepository;
  late DriftRepairRepository repairRepository;
  late FakeMediaService mediaService;
  late RecordingReminderScheduler reminderScheduler;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftCarProfileRepository(database);
    maintenanceRepository = DriftMaintenanceRepository(database);
    repairRepository = DriftRepairRepository(database);
    mediaService = FakeMediaService();
    reminderScheduler = RecordingReminderScheduler();
  });

  tearDown(() async {
    await database.close();
  });

  Future<int> createProfile() {
    return repository.createProfile(
      CarProfileInput(
        make: 'BMW',
        model: 'E46',
        engine: '3.0L',
        firstRegistrationMonth: DateTime(2003, 4),
        vin: 'WB1234567890',
        currentMileage: 120000,
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
        repairRepository: repairRepository,
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'plans a repair from the empty state and updates the profile counter',
    (tester) async {
      await createProfile();
      await pumpApp(tester);

      await _openRepairSectionFromProfile(tester);
      expect(find.text('No repairs yet'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Plan repair'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const ValueKey('repair-title-field')),
        'Timing belt replacement',
      );
      await tester.tap(find.text('Create Entry'));
      await tester.pumpAndSettle();

      expect(find.text('Timing belt replacement'), findsWidgets);
      await _disposeApp(tester);
      await pumpApp(tester);
      await tester.tap(find.text('BMW E46'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Repairs & modifications'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(
        find.byKey(const ValueKey('planned-repairs-count')),
        findsOneWidget,
      );
      expect(find.text('1 planned repair'), findsOneWidget);
      await _disposeApp(tester);
    },
  );

  testWidgets(
    'tracks a past modification and toggles between repairs and modifications',
    (tester) async {
      final carId = await createProfile();
      await repairRepository.createEntry(
        carId,
        const RepairEntryInput(
          status: RepairStatus.planned,
          isModification: false,
          area: RepairArea.engine,
          urgency: RepairUrgency.high,
          title: 'Water pump',
          parts: [],
        ),
      );
      await repairRepository.createEntry(
        carId,
        RepairEntryInput(
          status: RepairStatus.completed,
          isModification: true,
          area: RepairArea.suspension,
          title: 'Coilover conversion',
          completedAt: DateTime(2026, 4, 20),
          parts: const [],
        ),
      );

      await pumpApp(tester);
      await _openRepairSectionFromProfile(tester);

      expect(find.text('Water pump'), findsOneWidget);
      await tester.tap(find.text('Modifications'));
      await tester.pumpAndSettle();
      expect(find.text('Water pump'), findsNothing);
      expect(find.text('Coilover conversion'), findsOneWidget);
      expect(find.textContaining('Completed'), findsWidgets);
      await _disposeApp(tester);
    },
  );

  testWidgets('edits a repair and exposes the attachment pickers', (
    tester,
  ) async {
    final carId = await createProfile();
    final repairId = await repairRepository.createEntry(
      carId,
      const RepairEntryInput(
        status: RepairStatus.planned,
        isModification: false,
        area: RepairArea.electrics,
        urgency: RepairUrgency.medium,
        title: 'Alternator service',
        parts: [RepairPartInput(title: 'Old alternator')],
      ),
    );
    mediaService.nextPickedRepairImages = const [
      PickedMediaFile(
        path: '/tmp/alternator.jpg',
        originalName: 'alternator.jpg',
        kind: RepairAttachmentKind.image,
      ),
    ];

    await pumpApp(tester);
    await _openRepairSectionFromProfile(tester);
    await tester.tap(find.text('Alternator service'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('repair-description-field')),
      'Bearing noise at idle.',
    );
    final addPhotosButton = find.widgetWithText(OutlinedButton, 'Add photos');
    await tester.scrollUntilVisible(
      addPhotosButton,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(addPhotosButton);
    await tester.tap(addPhotosButton, warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(OutlinedButton, 'Add files'), findsOneWidget);
    final saveChangesButton = find.widgetWithText(FilledButton, 'Save Changes');
    await tester.scrollUntilVisible(
      saveChangesButton,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(saveChangesButton);
    await tester.tap(saveChangesButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    final details = await repairRepository.watchRepairEntry(repairId).first;
    expect(details, isNotNull);
    expect(details!.parts.single.title, 'Old alternator');
    expect(details.entry.description, 'Bearing noise at idle.');
    expect(find.text('Old alternator'), findsOneWidget);
    await _disposeApp(tester);
  });

  testWidgets('completes and reopens a planned repair from the detail screen', (
    tester,
  ) async {
    final carId = await createProfile();
    await repairRepository.createEntry(
      carId,
      const RepairEntryInput(
        status: RepairStatus.planned,
        isModification: false,
        area: RepairArea.chassis,
        urgency: RepairUrgency.high,
        title: 'Front control arms',
        parts: [],
      ),
    );

    await pumpApp(tester);
    await _openRepairSectionFromProfile(tester);
    await tester.tap(find.text('Front control arms'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Complete Repair'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Complete'));
    await tester.pumpAndSettle();

    expect(find.text('Reopen Repair'), findsOneWidget);
    await tester.tap(find.text('Reopen Repair'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reopen'));
    await tester.pumpAndSettle();

    expect(find.text('Complete Repair'), findsOneWidget);
    await _disposeApp(tester);
  });
}

Future<void> _openRepairSectionFromProfile(WidgetTester tester) async {
  await tester.tap(find.text('BMW E46'));
  await tester.pumpAndSettle();
  final openRepairsButton = find.byKey(const ValueKey('open-repairs-button'));
  await tester.scrollUntilVisible(
    openRepairsButton,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.ensureVisible(openRepairsButton);
  await tester.pumpAndSettle();
  await tester.tap(openRepairsButton, warnIfMissed: false);
  await tester.pumpAndSettle();
}

Future<void> _disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1));
}
