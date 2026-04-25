class RepairPart {
  const RepairPart({
    required this.id,
    required this.repairEntryId,
    required this.title,
    required this.link,
  });

  final int id;
  final int repairEntryId;
  final String title;
  final String? link;
}
