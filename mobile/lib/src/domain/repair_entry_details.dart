import 'package:carful/src/domain/repair_attachment.dart';
import 'package:carful/src/domain/repair_entry.dart';
import 'package:carful/src/domain/repair_part.dart';

class RepairEntryDetails {
  const RepairEntryDetails({
    required this.entry,
    required this.parts,
    required this.attachments,
  });

  final RepairEntry entry;
  final List<RepairPart> parts;
  final List<RepairAttachment> attachments;
}
