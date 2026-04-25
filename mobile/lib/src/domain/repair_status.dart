enum RepairStatus {
  planned('planned', 'Planned'),
  completed('completed', 'Completed');

  const RepairStatus(this.storageValue, this.label);

  final String storageValue;
  final String label;

  bool get isPlanned => this == RepairStatus.planned;
  bool get isCompleted => this == RepairStatus.completed;

  static RepairStatus fromStorage(String value) {
    return RepairStatus.values.firstWhere(
      (status) => status.storageValue == value,
      orElse: () => RepairStatus.planned,
    );
  }
}
