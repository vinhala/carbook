enum RepairAttachmentKind {
  image('image', 'Image'),
  file('file', 'File');

  const RepairAttachmentKind(this.storageValue, this.label);

  final String storageValue;
  final String label;

  bool get isImage => this == RepairAttachmentKind.image;

  static RepairAttachmentKind fromStorage(String value) {
    return RepairAttachmentKind.values.firstWhere(
      (kind) => kind.storageValue == value,
      orElse: () => RepairAttachmentKind.file,
    );
  }
}
