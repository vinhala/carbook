import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/domain/repair_attachment_input.dart';
import 'package:carful/src/domain/repair_entry_details.dart';
import 'package:carful/src/domain/repair_entry_input.dart';
import 'package:carful/src/domain/repair_overview.dart';
import 'package:carful/src/domain/repair_repository.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:carful/src/services/media_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef RepairOverviewRequest = ({int carId, bool modifications});

final repairControllerProvider = Provider<RepairController>(
  (ref) => RepairController(
    repository: ref.watch(repairRepositoryProvider),
    mediaService: ref.watch(mediaServiceProvider),
  ),
);

final repairOverviewProvider =
    StreamProvider.family<RepairOverview, RepairOverviewRequest>(
      (ref, request) => ref
          .watch(repairRepositoryProvider)
          .watchOverview(request.carId, modifications: request.modifications),
    );

final repairEntryProvider = StreamProvider.family<RepairEntryDetails?, int>(
  (ref, entryId) =>
      ref.watch(repairRepositoryProvider).watchRepairEntry(entryId),
);

final plannedRepairCountProvider = StreamProvider.family<int, int>(
  (ref, carId) =>
      ref.watch(repairRepositoryProvider).watchPlannedRepairCount(carId),
);

class RepairController {
  const RepairController({
    required this.repository,
    required this.mediaService,
  });

  final RepairRepository repository;
  final MediaService mediaService;

  Future<int> createEntry(
    int carProfileId,
    RepairEntryInput input, {
    List<PickedMediaFile> newAttachments = const [],
  }) async {
    final entryId = await repository.createEntry(carProfileId, input);
    if (newAttachments.isEmpty) {
      return entryId;
    }

    final attachments = await _storeAttachments(entryId, newAttachments);
    await repository.replaceExistingAttachmentSet(
      entryId,
      const [],
      attachments,
    );
    return entryId;
  }

  Future<void> updateEntry(
    int entryId,
    RepairEntryInput input, {
    List<int> retainedAttachmentIds = const [],
    List<PickedMediaFile> newAttachments = const [],
  }) async {
    await repository.updateEntry(entryId, input);
    final attachments = await _storeAttachments(entryId, newAttachments);
    final deletedPaths = await repository.replaceExistingAttachmentSet(
      entryId,
      retainedAttachmentIds,
      attachments,
    );
    await _deleteFiles(deletedPaths);
  }

  Future<void> deleteEntry(RepairEntryDetails details) async {
    final deletedPaths = await repository.deleteEntry(details.entry.id);
    await _deleteFiles(deletedPaths);
  }

  Future<void> markCompleted(int entryId) {
    return repository.markCompleted(entryId, DateTime.now());
  }

  Future<void> reopen(int entryId) => repository.reopen(entryId);

  Future<List<RepairAttachmentInput>> _storeAttachments(
    int entryId,
    List<PickedMediaFile> attachments,
  ) async {
    final stored = <RepairAttachmentInput>[];
    for (final attachment in attachments) {
      final file = await mediaService.storeRepairAttachment(
        attachment,
        repairEntryId: entryId,
      );
      stored.add(
        RepairAttachmentInput(
          kind: file.kind,
          storedPath: file.storedPath,
          originalName: file.originalName,
          mimeType: file.mimeType,
          fileExtension: file.fileExtension,
        ),
      );
    }
    return stored;
  }

  Future<void> _deleteFiles(List<String> paths) async {
    for (final path in paths) {
      await mediaService.deleteStoredFile(path);
    }
  }
}
