import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/car_profile_input.dart';
import 'package:carbook/src/domain/mileage_reminder_frequency.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:integration_test/integration_test.dart';

import '../test/support/test_app.dart';
import '../test/support/test_doubles.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;

  testWidgets('smoke flow plans and completes a repair', (tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final repository = DriftCarProfileRepository(database);
    final maintenanceRepository = DriftMaintenanceRepository(database);
    final repairRepository = DriftRepairRepository(database);
    final mediaService = FakeMediaService();
    final reminderScheduler = RecordingReminderScheduler();

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
        repairRepository: repairRepository,
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
        allowRuntimeFontFetching: true,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Toyota Tacoma'));
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
    await tester.tap(find.text('Plan repair'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('repair-title-field')),
      'Timing belt service',
    );
    await tester.tap(find.text('Create Entry'));
    await tester.pumpAndSettle();

    expect(find.text('Timing belt service'), findsWidgets);
    await tester.tap(find.text('Complete Repair'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Complete'));
    await tester.pumpAndSettle();

    expect(find.text('Reopen Repair'), findsOneWidget);
    await database.close();
  });
}
