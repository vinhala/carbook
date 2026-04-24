import 'package:carbook/src/domain/mileage_reminder_frequency.dart';

class CarProfileInput {
  const CarProfileInput({
    required this.make,
    required this.model,
    required this.engine,
    required this.firstRegistrationMonth,
    required this.vin,
    required this.currentMileage,
    required this.photoPath,
    required this.reminderFrequency,
    this.mileageUnit = 'mi',
  });

  final String make;
  final String model;
  final String engine;
  final DateTime firstRegistrationMonth;
  final String vin;
  final int currentMileage;
  final String mileageUnit;
  final String? photoPath;
  final MileageReminderFrequency reminderFrequency;
}
