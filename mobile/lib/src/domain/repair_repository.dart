import 'package:carbook/src/domain/repair_attachment_input.dart';
import 'package:carbook/src/domain/repair_entry_details.dart';
import 'package:carbook/src/domain/repair_entry_input.dart';
import 'package:carbook/src/domain/repair_overview.dart';

abstract class RepairRepository {
  Stream<RepairOverview> watchOverview(
    int carProfileId, {
    required bool modifications,
  });
  Stream<RepairEntryDetails?> watchRepairEntry(int entryId);
  Stream<int> watchPlannedRepairCount(int carProfileId);
  Future<int> createEntry(int carProfileId, RepairEntryInput input);
  Future<void> updateEntry(int entryId, RepairEntryInput input);
  Future<void> replaceAttachments(
    int entryId,
    List<RepairAttachmentInput> attachments,
  );
  Future<List<String>> deleteEntry(int entryId);
  Future<List<String>> replaceExistingAttachmentSet(
    int entryId,
    List<int> retainedAttachmentIds,
    List<RepairAttachmentInput> newAttachments,
  );
  Future<void> markCompleted(int entryId, DateTime completedAt);
  Future<void> reopen(int entryId);
}
