import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/mileage_reminder_frequency.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/test_doubles.dart';

void main() {
  late RecordingNotificationClient client;
  late RollingReminderScheduler scheduler;

  setUp(() {
    client = RecordingNotificationClient();
    scheduler = RollingReminderScheduler(client, scheduleWindow: 4);
  });

  test('schedules a rolling window of future reminders', () async {
    final profile = CarProfile(
      id: 7,
      make: 'Toyota',
      model: 'Tacoma',
      engine: '3.5L V6',
      firstRegistrationMonth: DateTime(2018, 5),
      vin: 'JT1234567890',
      currentMileage: 65000,
      mileageUnit: 'mi',
      photoPath: null,
      reminderFrequency: MileageReminderFrequency.monthly,
      lastMileageUpdatedAt: DateTime.now().subtract(const Duration(days: 90)),
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
      updatedAt: DateTime.now().subtract(const Duration(days: 30)),
    );

    await scheduler.syncForProfile(profile);

    expect(client.cancelledIds, [700, 701, 702, 703]);
    expect(client.scheduledCalls, hasLength(4));
    expect(
      client.scheduledCalls.every(
        (call) => call.scheduledFor.isAfter(DateTime.now()),
      ),
      isTrue,
    );
  });

  test('cancels only when reminders are turned off', () async {
    final profile = CarProfile(
      id: 2,
      make: 'BMW',
      model: 'E46',
      engine: '3.0L',
      firstRegistrationMonth: DateTime(2003, 4),
      vin: 'WB1234567890',
      currentMileage: 120000,
      mileageUnit: 'mi',
      photoPath: null,
      reminderFrequency: MileageReminderFrequency.never,
      lastMileageUpdatedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await scheduler.syncForProfile(profile);

    expect(client.cancelledIds, [200, 201, 202, 203]);
    expect(client.scheduledCalls, isEmpty);
  });
}
