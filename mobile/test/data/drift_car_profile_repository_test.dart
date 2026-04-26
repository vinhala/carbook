import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository repository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftCarProfileRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates and fetches a profile', () async {
    final id = await repository.createProfile(
      CarProfileInput(
        make: 'Toyota',
        model: 'Tacoma',
        engine: '3.5L V6',
        firstRegistrationMonth: DateTime(2018, 5),
        vin: 'JT1234567890',
        currentMileage: 65240,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.monthly,
      ),
    );

    final profile = await repository.getProfile(id);

    expect(profile, isNotNull);
    expect(profile!.make, 'Toyota');
    expect(profile.model, 'Tacoma');
    expect(profile.currentMileage, 65240);
  });

  test('sorts watched profiles by updated time descending', () async {
    final firstId = await repository.createProfile(
      CarProfileInput(
        make: 'Mazda',
        model: 'MX-5',
        engine: '2.0L',
        firstRegistrationMonth: DateTime(2016, 2),
        vin: 'JM1234567890',
        currentMileage: 40500,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.monthly,
      ),
    );

    final secondId = await repository.createProfile(
      CarProfileInput(
        make: 'BMW',
        model: 'E46',
        engine: '3.0L',
        firstRegistrationMonth: DateTime(2003, 4),
        vin: 'WB1234567890',
        currentMileage: 120000,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.weekly,
      ),
    );

    await repository.updateMileage(
      firstId,
      40600,
      DateTime.now().add(const Duration(minutes: 1)),
    );
    final profiles = await repository.watchProfiles().first;

    expect(profiles.first.id, firstId);
    expect(profiles.last.id, secondId);
  });

  test('deletes profiles', () async {
    final id = await repository.createProfile(
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

    await repository.deleteProfile(id);

    expect(await repository.getProfile(id), isNull);
  });
}
