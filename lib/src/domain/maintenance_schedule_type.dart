enum MaintenanceScheduleType {
  distance,
  time;

  String get label => switch (this) {
    distance => 'Distance',
    time => 'Time',
  };

  String get storageValue => name;

  static MaintenanceScheduleType fromStorage(String value) {
    return MaintenanceScheduleType.values.firstWhere(
      (type) => type.storageValue == value,
      orElse: () => MaintenanceScheduleType.distance,
    );
  }
}
