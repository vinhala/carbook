class WorkshopManual {
  const WorkshopManual({
    required this.id,
    required this.carProfileId,
    required this.backendManualId,
    required this.localPath,
    required this.originalName,
    required this.byteSize,
    required this.createdAt,
  });

  final int id;
  final int carProfileId;
  final String backendManualId;
  final String localPath;
  final String originalName;
  final int byteSize;
  final DateTime createdAt;
}
