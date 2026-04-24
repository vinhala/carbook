enum RepairArea {
  engine('engine', 'Engine'),
  chassis('chassis', 'Chassis'),
  body('body', 'Body'),
  suspension('suspension', 'Suspension'),
  electrics('electrics', 'Electrics'),
  interior('interior', 'Interior'),
  other('other', 'Other');

  const RepairArea(this.storageValue, this.label);

  final String storageValue;
  final String label;

  static RepairArea fromStorage(String value) {
    return RepairArea.values.firstWhere(
      (area) => area.storageValue == value,
      orElse: () => RepairArea.other,
    );
  }
}
