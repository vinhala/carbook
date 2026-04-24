class MaintenanceDueStatus {
  const MaintenanceDueStatus({
    required this.isOverdue,
    required this.nextDueMileage,
    required this.nextDueDate,
    required this.overdueMileage,
    required this.remainingMileage,
    required this.overdueDays,
    required this.remainingDays,
    required this.lastPerformedAt,
    required this.lastPerformedMileage,
  });

  final bool isOverdue;
  final int? nextDueMileage;
  final DateTime? nextDueDate;
  final int? overdueMileage;
  final int? remainingMileage;
  final int? overdueDays;
  final int? remainingDays;
  final DateTime? lastPerformedAt;
  final int? lastPerformedMileage;
}
