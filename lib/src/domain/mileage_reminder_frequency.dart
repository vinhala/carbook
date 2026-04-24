enum MileageReminderFrequency {
  weekly,
  monthly,
  quarterly,
  never;

  String get label => switch (this) {
    weekly => 'Weekly',
    monthly => 'Monthly',
    quarterly => 'Quarterly',
    never => 'Never',
  };

  bool get showsWarning => this == quarterly || this == never;

  String get storageValue => name;

  static MileageReminderFrequency fromStorage(String value) {
    return MileageReminderFrequency.values.firstWhere(
      (frequency) => frequency.storageValue == value,
      orElse: () => MileageReminderFrequency.monthly,
    );
  }
}
