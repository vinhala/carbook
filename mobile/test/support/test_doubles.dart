import 'dart:io';

import 'package:carbook/src/domain/ai_schedule_suggestion.dart';
import 'package:carbook/src/domain/assistant_message_source.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/maintenance_schedule_entry.dart';
import 'package:carbook/src/domain/repair_entry.dart';
import 'package:carbook/src/domain/workshop_manual.dart';
import 'package:carbook/src/services/ai_backend_service.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';

class FakeMediaService implements MediaService {
  String? nextPickedPath;
  List<PickedMediaFile> nextPickedRepairImages = const [];
  List<PickedMediaFile> nextPickedRepairFiles = const [];
  List<PickedDocumentFile> nextPickedWorkshopManuals = const [];
  final List<String?> deletedPaths = [];
  final List<StoredMediaFile> storedFiles = [];
  final List<StoredDocumentFile> storedDocuments = [];

  @override
  Future<String?> pickCarImage() async => nextPickedPath;

  @override
  Future<List<PickedMediaFile>> pickRepairFiles() async =>
      nextPickedRepairFiles;

  @override
  Future<List<PickedMediaFile>> pickRepairImages() async =>
      nextPickedRepairImages;

  @override
  Future<List<PickedDocumentFile>> pickWorkshopManuals() async =>
      nextPickedWorkshopManuals;

  @override
  Future<StoredMediaFile> storeRepairAttachment(
    PickedMediaFile file, {
    required int repairEntryId,
  }) async {
    final stored = StoredMediaFile(
      storedPath: '/stored/repair_$repairEntryId/${file.originalName}',
      originalName: file.originalName,
      kind: file.kind,
      fileExtension: file.originalName.contains('.')
          ? file.originalName.split('.').last
          : null,
    );
    storedFiles.add(stored);
    return stored;
  }

  @override
  Future<StoredDocumentFile> storeWorkshopManual(
    PickedDocumentFile file, {
    required int carProfileId,
  }) async {
    final stored = StoredDocumentFile(
      storedPath: '/stored/manual_$carProfileId/${file.originalName}',
      originalName: file.originalName,
      byteSize: file.byteSize,
    );
    storedDocuments.add(stored);
    return stored;
  }

  @override
  Future<void> deleteStoredFile(String? path) async {
    deletedPaths.add(path);
  }
}

class FakeAiBackendService implements AiBackendService {
  final List<CarProfile> upsertedProfiles = [];
  final List<File> uploadedFiles = [];
  final List<String> deletedManualIds = [];
  final List<String> sentMessages = [];
  List<AiScheduleSuggestion> nextSuggestions = const [];
  AssistantBackendResponse nextAssistantResponse =
      const AssistantBackendResponse(
        status: 'answered',
        conversationId: 'conv_test',
        messageId: 'msg_test',
        content: 'Test answer',
        sources: [],
        rejectionReasonCode: null,
        usedWebSearch: true,
        usedFileSearch: true,
      );

  @override
  Future<void> deleteManual(CarProfile profile, String backendManualId) async {
    deletedManualIds.add(backendManualId);
  }

  @override
  Future<List<AiScheduleSuggestion>> generateMaintenanceSuggestions({
    required CarProfile profile,
    required List<MaintenanceScheduleEntry> schedule,
    required List<RepairEntry> repairs,
    required List<WorkshopManual> manuals,
  }) async {
    return nextSuggestions;
  }

  @override
  Future<AssistantBackendResponse> sendAssistantMessage({
    required String clientId,
    required String? conversationId,
    required String message,
    required CarProfile profile,
    required List<MaintenanceScheduleEntry> schedule,
    required List<RepairEntry> repairs,
    required List<WorkshopManual> manuals,
  }) async {
    sentMessages.add(message);
    return nextAssistantResponse;
  }

  @override
  Future<void> upsertCar(CarProfile profile) async {
    upsertedProfiles.add(profile);
  }

  @override
  Future<BackendManualUploadResult> uploadManual(
    CarProfile profile,
    File file,
  ) async {
    uploadedFiles.add(file);
    return BackendManualUploadResult(
      backendManualId: 'manual_${uploadedFiles.length}',
      originalName: file.path.split('/').last,
      byteSize: 1024,
    );
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
