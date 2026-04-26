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

  testWidgets('creates an overdue distance item and logs performed work', (
    tester,
  ) async {
    await repository.createProfile(
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

    await tester.tap(find.text('Toyota Tacoma'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Maintenance schedule'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('No maintenance items yet'), findsOneWidget);
    await tester.tap(find.text('Create maintenance item'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Oil change');
    await tester.enterText(find.byType(TextFormField).at(1), '5000');
    await tester.tap(find.text('Create Item'));
    await tester.pumpAndSettle();

    expect(find.text('Oil change'), findsOneWidget);

    await tester.tap(find.text('Log'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), '6500');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Pennzoil Platinum',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Log Performed Work'));
    await tester.pumpAndSettle();

    expect(find.text('6,500 mi'), findsWidgets);
    expect(find.text('Pennzoil Platinum'), findsOneWidget);
    await _disposeApp(tester);
  });

  testWidgets('creates a time-based item and shows its schedule label', (
    tester,
  ) async {
    await repository.createProfile(
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
    await tester.scrollUntilVisible(
      find.text('Maintenance schedule'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create maintenance item'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Cabin filter');
    await tester.tap(find.text('Time'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(1), '6');
    await tester.tap(find.text('Create Time-Based Item'));
    await tester.pumpAndSettle();

    expect(find.text('Cabin filter'), findsOneWidget);
    expect(find.text('Every 6 months'), findsOneWidget);
    await _disposeApp(tester);
  });
}

Future<void> _disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1));
}
