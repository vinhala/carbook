import 'package:carful/src/data/local/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_app.dart';
import '../support/test_doubles.dart';

void main() {
  testWidgets('renders garage chrome in German', (tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftCarProfileRepository(database);
    final maintenanceRepository = DriftMaintenanceRepository(database);

    await tester.pumpWidget(
      buildTestApp(
        database: database,
        repository: repository,
        maintenanceRepository: maintenanceRepository,
        mediaService: FakeMediaService(),
        reminderScheduler: RecordingReminderScheduler(),
        locale: const Locale('de'),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Deine Garage ist bereit'), findsOneWidget);
    expect(find.text('Erstes Profil erstellen'), findsOneWidget);
    expect(find.text('Auto hinzufügen'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1));
  });
}
