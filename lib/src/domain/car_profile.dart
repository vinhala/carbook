import 'package:carbook/src/domain/mileage_reminder_frequency.dart';

class CarProfile {
  const CarProfile({
    required this.id,
    required this.make,
    required this.model,
    required this.engine,
    required this.firstRegistrationMonth,
    required this.vin,
    required this.currentMileage,
    required this.mileageUnit,
    required this.photoPath,
    required this.reminderFrequency,
    required this.lastMileageUpdatedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String make;
  final String model;
  final String engine;
  final DateTime firstRegistrationMonth;
  final String vin;
  final int currentMileage;
  final String mileageUnit;
  final String? photoPath;
  final MileageReminderFrequency reminderFrequency;
  final DateTime lastMileageUpdatedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get displayName => '$make $model';
}
