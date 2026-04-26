import 'package:carful/src/domain/repair_attachment_kind.dart';

class RepairAttachmentInput {
  const RepairAttachmentInput({
    required this.kind,
    required this.storedPath,
    required this.originalName,
    this.mimeType,
    this.fileExtension,
  });

  final RepairAttachmentKind kind;
  final String storedPath;
  final String originalName;
  final String? mimeType;
  final String? fileExtension;
}
