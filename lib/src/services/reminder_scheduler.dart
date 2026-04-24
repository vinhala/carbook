import 'package:carbook/src/core/utils/date_time_utils.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/mileage_reminder_frequency.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class ReminderScheduler {
  Future<void> syncForProfile(CarProfile profile);
  Future<void> cancelForProfile(int profileId);
}

abstract class NotificationClient {
  Future<void> initialize();
  Future<void> requestPermissions();
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledFor,
  });
  Future<void> cancel(int id);
}

class FlutterLocalNotificationsClient implements NotificationClient {
  FlutterLocalNotificationsClient(this._plugin);

  static const AndroidNotificationDetails _androidDetails =
      AndroidNotificationDetails(
        'mileage_updates',
        'Mileage reminders',
        channelDescription: 'Reminders to keep each car mileage up to date.',
        importance: Importance.high,
        priority: Priority.high,
      );

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<void> initialize() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(settings: initializationSettings);
  }

  @override
  Future<void> requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledFor,
  }) async {
    final scheduledDate = tz.TZDateTime.from(scheduledFor, tz.local);
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: _androidDetails,
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  @override
  Future<void> cancel(int id) => _plugin.cancel(id: id);
}

class RollingReminderScheduler implements ReminderScheduler {
  RollingReminderScheduler(this._client, {this.scheduleWindow = 8});

  final NotificationClient _client;
  final int scheduleWindow;

  @override
  Future<void> syncForProfile(CarProfile profile) async {
    await cancelForProfile(profile.id);
    if (profile.reminderFrequency == MileageReminderFrequency.never) {
      return;
    }

    final title = 'Mileage update reminder';
    final body = 'Update the mileage for ${profile.displayName}.';
    final scheduleDates = _buildScheduleDates(
      anchor: reminderAnchor(profile.lastMileageUpdatedAt),
      frequency: profile.reminderFrequency,
      now: DateTime.now(),
    );

    for (var index = 0; index < scheduleDates.length; index++) {
      await _client.schedule(
        id: _notificationId(profile.id, index),
        title: title,
        body: body,
        scheduledFor: scheduleDates[index],
      );
    }
  }

  @override
  Future<void> cancelForProfile(int profileId) async {
    for (var slot = 0; slot < scheduleWindow; slot++) {
      await _client.cancel(_notificationId(profileId, slot));
    }
  }

  List<DateTime> _buildScheduleDates({
    required DateTime anchor,
    required MileageReminderFrequency frequency,
    required DateTime now,
  }) {
    final dates = <DateTime>[];
    var next = anchor;

    while (!next.isAfter(now)) {
      next = _advance(next, frequency);
    }

    for (var slot = 0; slot < scheduleWindow; slot++) {
      dates.add(next);
      next = _advance(next, frequency);
    }

    return dates;
  }

  DateTime _advance(DateTime current, MileageReminderFrequency frequency) {
    return switch (frequency) {
      MileageReminderFrequency.weekly => current.add(const Duration(days: 7)),
      MileageReminderFrequency.monthly => addMonthsClamped(current, 1),
      MileageReminderFrequency.quarterly => addMonthsClamped(current, 3),
      MileageReminderFrequency.never => current,
    };
  }

  int _notificationId(int profileId, int slot) => (profileId * 100) + slot;
}
