import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';
import '../support/test_doubles.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository repository;
  late DriftMaintenanceRepository maintenanceRepository;
  late FakeMediaService mediaService;
  late RecordingReminderScheduler reminderScheduler;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftCarProfileRepository(database);
    maintenanceRepository = DriftMaintenanceRepository(database);
    mediaService = FakeMediaService();
    reminderScheduler = RecordingReminderScheduler();
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('shows the empty garage state', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        database: database,
        repository: repository,
        maintenanceRepository: maintenanceRepository,
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Your garage is ready'), findsOneWidget);
    expect(find.text('Create your first profile'), findsOneWidget);
    await _disposeApp(tester);
  });

  testWidgets('creates a car profile and lands on the detail screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        database: database,
        repository: repository,
        maintenanceRepository: maintenanceRepository,
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create your first profile'));
    await tester.pumpAndSettle();
    expect(find.text('Add New Car'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Toyota');
    await tester.enterText(find.byType(TextFormField).at(1), 'Tacoma');
    await tester.enterText(find.byType(TextFormField).at(2), '3.5L V6');
    await tester.enterText(find.byType(TextFormField).at(3), 'JT1234567890');
    await tester.enterText(find.byType(TextFormField).at(4), '65240');
    await tester.scrollUntilVisible(
      find.text('Create Profile'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Create Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Toyota Tacoma'), findsWidgets);
    await tester.scrollUntilVisible(
      find.text('Workshop manuals'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.textContaining(
        'Add PDF workshop manuals so Carful AI can answer questions about this vehicle',
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('add-manual-button')), findsOneWidget);
    expect(reminderScheduler.syncedProfileIds, isNotEmpty);
    await _disposeApp(tester);
  });

  testWidgets('edits a profile, shows warning state, and saves changes', (
    tester,
  ) async {
    final profileId = await repository.createProfile(
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

    await tester.pumpWidget(
      buildTestApp(
        database: database,
        repository: repository,
        maintenanceRepository: maintenanceRepository,
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('BMW E46'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(2), '3.2L stroker');
    await tester.scrollUntilVisible(
      find.text('Save Changes'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    final profile = await repository.getProfile(profileId);
    expect(profile, isNotNull);
    expect(profile!.engine, '3.2L stroker');
    expect(profile.reminderFrequency, MileageReminderFrequency.monthly);
    await _disposeApp(tester);
  });

  testWidgets('deletes a profile from edit mode', (tester) async {
    await repository.createProfile(
      CarProfileInput(
        make: 'Subaru',
        model: 'Forester',
        engine: '2.5L',
        firstRegistrationMonth: DateTime(2015, 9),
        vin: 'SU1234567890',
        currentMileage: 100500,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.never,
      ),
    );

    await tester.pumpWidget(
      buildTestApp(
        database: database,
        repository: repository,
        maintenanceRepository: maintenanceRepository,
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Subaru Forester'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Delete Profile'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Delete Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Your garage is ready'), findsOneWidget);
    expect(reminderScheduler.cancelledProfileIds, isNotEmpty);
    await _disposeApp(tester);
  });
}

Future<void> _disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1));
}
