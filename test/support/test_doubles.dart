import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';

class FakeMediaService implements MediaService {
  String? nextPickedPath;
  final List<String?> deletedPaths = [];

  @override
  Future<String?> pickCarImage() async => nextPickedPath;

  @override
  Future<void> deleteStoredFile(String? path) async {
    deletedPaths.add(path);
  }
}

class RecordingReminderScheduler implements ReminderScheduler {
  final List<int> syncedProfileIds = [];
  final List<int> cancelledProfileIds = [];

  @override
  Future<void> cancelForProfile(int profileId) async {
    cancelledProfileIds.add(profileId);
  }

  @override
  Future<void> syncForProfile(CarProfile profile) async {
    syncedProfileIds.add(profile.id);
  }
}

class RecordingNotificationClient implements NotificationClient {
  final List<int> cancelledIds = [];
  final List<ScheduledNotificationCall> scheduledCalls = [];
  bool initialized = false;
  bool permissionsRequested = false;

  @override
  Future<void> cancel(int id) async {
    cancelledIds.add(id);
  }

  @override
  Future<void> initialize() async {
    initialized = true;
  }

  @override
  Future<void> requestPermissions() async {
    permissionsRequested = true;
  }

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledFor,
  }) async {
    scheduledCalls.add(
      ScheduledNotificationCall(
        id: id,
        title: title,
        body: body,
        scheduledFor: scheduledFor,
      ),
    );
  }
}

class ScheduledNotificationCall {
  const ScheduledNotificationCall({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledFor,
  });

  final int id;
  final String title;
  final String body;
  final DateTime scheduledFor;
}
