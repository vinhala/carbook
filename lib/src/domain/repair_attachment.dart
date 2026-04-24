import 'package:carbook/src/domain/repair_attachment_kind.dart';

class RepairAttachment {
  const RepairAttachment({
    required this.id,
    required this.repairEntryId,
    required this.kind,
    required this.storedPath,
    required this.originalName,
    required this.mimeType,
    required this.fileExtension,
    required this.createdAt,
  });

  final int id;
  final int repairEntryId;
  final RepairAttachmentKind kind;
  final String storedPath;
  final String originalName;
  final String? mimeType;
  final String? fileExtension;
  final DateTime createdAt;
}
