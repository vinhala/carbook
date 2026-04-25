class MaintenanceLogEntry {
  const MaintenanceLogEntry({
    required this.id,
    required this.maintenanceItemId,
    required this.performedAt,
    required this.mileage,
    required this.note,
    required this.createdAt,
  });

  final int id;
  final int maintenanceItemId;
  final DateTime performedAt;
  final int mileage;
  final String? note;
  final DateTime createdAt;
}
