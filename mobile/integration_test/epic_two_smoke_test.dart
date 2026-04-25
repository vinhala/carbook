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

  testWidgets('smoke flow creates, updates, and reopens a profile', (
    tester,
  ) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    final repository = DriftCarProfileRepository(database);
    final maintenanceRepository = DriftMaintenanceRepository(database);
    final mediaService = FakeMediaService();
    final reminderScheduler = RecordingReminderScheduler();

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

    await tester.tap(find.byIcon(Icons.edit_outlined));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(4), '66000');
    await tester.scrollUntilVisible(
      find.text('Save Changes'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    expect(find.textContaining('66,000 mi'), findsOneWidget);

    final profiles = await repository.watchProfiles().first;
    expect(profiles.single.currentMileage, 66000);
    expect(profiles.single.reminderFrequency, MileageReminderFrequency.monthly);

    await repository.createProfile(
      CarProfileInput(
        make: 'Mazda',
        model: 'MX-5',
        engine: '2.0L',
        firstRegistrationMonth: DateTime(2016, 2),
        vin: 'JM1234567890',
        currentMileage: 45000,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.weekly,
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

    expect(find.text('Mazda MX-5'), findsOneWidget);

    await database.close();
  });
}
