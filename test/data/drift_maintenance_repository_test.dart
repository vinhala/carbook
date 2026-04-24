import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/car_profile_input.dart';
import 'package:carbook/src/domain/maintenance_item_input.dart';
import 'package:carbook/src/domain/maintenance_log_input.dart';
import 'package:carbook/src/domain/maintenance_schedule_type.dart';
import 'package:carbook/src/domain/maintenance_time_unit.dart';
import 'package:carbook/src/domain/mileage_reminder_frequency.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository carProfileRepository;
  late DriftMaintenanceRepository maintenanceRepository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    carProfileRepository = DriftCarProfileRepository(database);
    maintenanceRepository = DriftMaintenanceRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'creates distance-based maintenance items with overdue baseline state',
    () async {
      final profileId = await carProfileRepository.createProfile(
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

      await maintenanceRepository.createItem(
        profileId,
        const MaintenanceItemInput(
          description: 'Oil change',
          scheduleType: MaintenanceScheduleType.distance,
          intervalValue: 5000,
        ),
      );

      final entries = await maintenanceRepository
          .watchSchedule(profileId)
          .first;

      expect(entries, hasLength(1));
      expect(entries.single.item.description, 'Oil change');
      expect(entries.single.dueStatus.isOverdue, isTrue);
      expect(entries.single.dueStatus.nextDueMileage, 5000);
      expect(entries.single.dueStatus.overdueMileage, 60240);
    },
  );

  test(
    'creates time-based maintenance items anchored to first registration',
    () async {
      final now = DateTime.now();
      final profileId = await carProfileRepository.createProfile(
        CarProfileInput(
          make: 'BMW',
          model: 'E46',
          engine: '3.0L',
          firstRegistrationMonth: now.subtract(const Duration(days: 400)),
          vin: 'WB1234567890',
          currentMileage: 120000,
          photoPath: null,
          reminderFrequency: MileageReminderFrequency.monthly,
        ),
      );

      await maintenanceRepository.createItem(
        profileId,
        const MaintenanceItemInput(
          description: 'Cabin filter',
          scheduleType: MaintenanceScheduleType.time,
          intervalValue: 6,
          timeUnit: MaintenanceTimeUnit.months,
        ),
      );

      final entries = await maintenanceRepository
          .watchSchedule(profileId)
          .first;

      expect(entries, hasLength(1));
      expect(entries.single.item.isTimeBased, isTrue);
      expect(entries.single.dueStatus.isOverdue, isTrue);
      expect(entries.single.dueStatus.nextDueDate, isNotNull);
      expect(entries.single.dueStatus.overdueDays, greaterThan(0));
    },
  );

  test(
    'logging performed work recalculates next due state and raises profile mileage',
    () async {
      final profileId = await carProfileRepository.createProfile(
        CarProfileInput(
          make: 'Mazda',
          model: 'MX-5',
          engine: '2.0L',
          firstRegistrationMonth: DateTime(2016, 2),
          vin: 'JM1234567890',
          currentMileage: 6000,
          photoPath: null,
          reminderFrequency: MileageReminderFrequency.monthly,
        ),
      );

      final itemId = await maintenanceRepository.createItem(
        profileId,
        const MaintenanceItemInput(
          description: 'Oil change',
          scheduleType: MaintenanceScheduleType.distance,
          intervalValue: 5000,
        ),
      );

      await maintenanceRepository.addPerformedWork(
        itemId,
        MaintenanceLogInput(
          performedAt: DateTime.now().subtract(const Duration(days: 1)),
          mileage: 6200,
          note: 'Full synthetic',
        ),
      );

      final details = await maintenanceRepository
          .watchMaintenanceItem(itemId)
          .first;
      final profile = await carProfileRepository.getProfile(profileId);

      expect(details, isNotNull);
      expect(details!.logs, hasLength(1));
      expect(details.dueStatus.isOverdue, isFalse);
      expect(details.dueStatus.nextDueMileage, 11200);
      expect(profile!.currentMileage, 6200);
    },
  );

  test(
    'does not lower the car profile mileage when logging older work',
    () async {
      final profileId = await carProfileRepository.createProfile(
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

      final itemId = await maintenanceRepository.createItem(
        profileId,
        const MaintenanceItemInput(
          description: 'Brake fluid',
          scheduleType: MaintenanceScheduleType.distance,
          intervalValue: 30000,
        ),
      );

      await maintenanceRepository.addPerformedWork(
        itemId,
        MaintenanceLogInput(
          performedAt: DateTime.now().subtract(const Duration(days: 30)),
          mileage: 99500,
          note: 'Backfilled service note',
        ),
      );

      final profile = await carProfileRepository.getProfile(profileId);

      expect(profile, isNotNull);
      expect(profile!.currentMileage, 100500);
    },
  );

  test('sorts overdue distance items before time items by severity', () async {
    final now = DateTime.now();
    final profileId = await carProfileRepository.createProfile(
      CarProfileInput(
        make: 'Honda',
        model: 'Pilot',
        engine: '3.5L',
        firstRegistrationMonth: now.subtract(const Duration(days: 500)),
        vin: 'HO1234567890',
        currentMileage: 15000,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.monthly,
      ),
    );

    await maintenanceRepository.createItem(
      profileId,
      const MaintenanceItemInput(
        description: 'Major service',
        scheduleType: MaintenanceScheduleType.distance,
        intervalValue: 5000,
      ),
    );
    await maintenanceRepository.createItem(
      profileId,
      const MaintenanceItemInput(
        description: 'Minor service',
        scheduleType: MaintenanceScheduleType.distance,
        intervalValue: 12000,
      ),
    );
    await maintenanceRepository.createItem(
      profileId,
      const MaintenanceItemInput(
        description: 'Cabin filter',
        scheduleType: MaintenanceScheduleType.time,
        intervalValue: 6,
        timeUnit: MaintenanceTimeUnit.months,
      ),
    );

    final entries = await maintenanceRepository.watchSchedule(profileId).first;

    expect(entries.map((entry) => entry.item.description).toList(), [
      'Major service',
      'Minor service',
      'Cabin filter',
    ]);
  });
}
