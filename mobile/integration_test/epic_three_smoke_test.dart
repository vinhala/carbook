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

  testWidgets('smoke flow creates and logs a maintenance item', (tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final repository = DriftCarProfileRepository(database);
    final maintenanceRepository = DriftMaintenanceRepository(database);
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
        mediaService: mediaService,
        reminderScheduler: reminderScheduler,
        allowRuntimeFontFetching: true,
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
    await tester.tap(find.widgetWithText(FilledButton, 'Log Performed Work'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Due in 5,000 mi'), findsWidgets);

    await database.close();
  });
}
