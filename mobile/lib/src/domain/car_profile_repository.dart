import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/car_profile_input.dart';

abstract class CarProfileRepository {
  Stream<List<CarProfile>> watchProfiles();
  Future<CarProfile?> getProfile(int id);
  Future<int> createProfile(CarProfileInput input);
  Future<void> updateProfile(int id, CarProfileInput input);
  Future<void> deleteProfile(int id);
  Future<void> updateMileage(int id, int mileage, DateTime updatedAt);
}
