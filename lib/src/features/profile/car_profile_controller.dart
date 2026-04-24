import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/car_profile_input.dart';
import 'package:carbook/src/domain/car_profile_repository.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:carbook/src/services/reminder_scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediaServiceProvider = Provider<MediaService>(
  (ref) =>
      throw UnimplementedError('MediaService must be overridden at startup.'),
);

final reminderSchedulerProvider = Provider<ReminderScheduler>(
  (ref) => throw UnimplementedError(
    'ReminderScheduler must be overridden at startup.',
  ),
);

final carProfileControllerProvider = Provider<CarProfileController>(
  (ref) => CarProfileController(
    repository: ref.watch(carProfileRepositoryProvider),
    mediaService: ref.watch(mediaServiceProvider),
    reminderScheduler: ref.watch(reminderSchedulerProvider),
  ),
);

final garageProfilesProvider = StreamProvider<List<CarProfile>>(
  (ref) => ref.watch(carProfileRepositoryProvider).watchProfiles(),
);

final carProfileProvider = StreamProvider.family<CarProfile?, int>((
  ref,
  carId,
) {
  return ref
      .watch(carProfileRepositoryProvider)
      .watchProfiles()
      .map(
        (profiles) => profiles.cast<CarProfile?>().firstWhere(
          (profile) => profile?.id == carId,
          orElse: () => null,
        ),
      );
});

class CarProfileController {
  CarProfileController({
    required this.repository,
    required this.mediaService,
    required this.reminderScheduler,
  });

  final CarProfileRepository repository;
  final MediaService mediaService;
  final ReminderScheduler reminderScheduler;

  Future<int> createProfile(CarProfileInput input) async {
    final profileId = await repository.createProfile(input);
    final profile = await repository.getProfile(profileId);
    if (profile != null) {
      await reminderScheduler.syncForProfile(profile);
    }
    return profileId;
  }

  Future<void> updateProfile(
    int profileId,
    CarProfileInput input, {
    String? previousPhotoPath,
  }) async {
    await repository.updateProfile(profileId, input);
    if (previousPhotoPath != null && previousPhotoPath != input.photoPath) {
      await mediaService.deleteStoredFile(previousPhotoPath);
    }
    final profile = await repository.getProfile(profileId);
    if (profile != null) {
      await reminderScheduler.syncForProfile(profile);
    }
  }

  Future<void> updateMileage(int profileId, int mileage) async {
    final updatedAt = DateTime.now();
    await repository.updateMileage(profileId, mileage, updatedAt);
    final profile = await repository.getProfile(profileId);
    if (profile != null) {
      await reminderScheduler.syncForProfile(profile);
    }
  }

  Future<void> deleteProfile(CarProfile profile) async {
    await repository.deleteProfile(profile.id);
    await reminderScheduler.cancelForProfile(profile.id);
    await mediaService.deleteStoredFile(profile.photoPath);
  }
}
