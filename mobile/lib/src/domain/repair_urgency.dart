enum RepairUrgency {
  low('low', 'Low', 0),
  medium('medium', 'Medium', 1),
  high('high', 'High', 2);

  const RepairUrgency(this.storageValue, this.label, this.priority);

  final String storageValue;
  final String label;
  final int priority;

  static RepairUrgency fromStorage(String value) {
    return RepairUrgency.values.firstWhere(
      (urgency) => urgency.storageValue == value,
      orElse: () => RepairUrgency.medium,
    );
  }
}
