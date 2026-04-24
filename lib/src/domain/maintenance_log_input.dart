class MaintenanceLogInput {
  const MaintenanceLogInput({
    required this.performedAt,
    required this.mileage,
    this.note,
  });

  final DateTime performedAt;
  final int mileage;
  final String? note;
}
