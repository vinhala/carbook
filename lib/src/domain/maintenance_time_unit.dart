enum MaintenanceTimeUnit {
  weeks,
  months,
  years;

  String get label => switch (this) {
    weeks => 'Weeks',
    months => 'Months',
    years => 'Years',
  };

  String formatInterval(int value) {
    final unit = switch (this) {
      weeks => value == 1 ? 'week' : 'weeks',
      months => value == 1 ? 'month' : 'months',
      years => value == 1 ? 'year' : 'years',
    };
    return '$value $unit';
  }

  String get storageValue => name;

  static MaintenanceTimeUnit fromStorage(String value) {
    return MaintenanceTimeUnit.values.firstWhere(
      (unit) => unit.storageValue == value,
      orElse: () => MaintenanceTimeUnit.months,
    );
  }
}
