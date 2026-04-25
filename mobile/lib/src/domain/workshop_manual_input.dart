class WorkshopManualInput {
  const WorkshopManualInput({
    required this.backendManualId,
    required this.localPath,
    required this.originalName,
    required this.byteSize,
  });

  final String backendManualId;
  final String localPath;
  final String originalName;
  final int byteSize;
}
