import 'dart:io';

import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/car_profile_input.dart';
import 'package:carbook/src/domain/car_profile_repository.dart';
import 'package:carbook/src/domain/workshop_manual.dart';
import 'package:carbook/src/domain/workshop_manual_input.dart';
import 'package:carbook/src/domain/workshop_manual_repository.dart';
import 'package:carbook/src/services/ai_backend_service.dart';
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
    workshopManualRepository: ref.watch(workshopManualRepositoryProvider),
    aiBackendService: ref.watch(aiBackendServiceProvider),
    mediaService: ref.watch(mediaServiceProvider),
    reminderScheduler: ref.watch(reminderSchedulerProvider),
  ),
);

final garageProfilesProvider = StreamProvider<List<CarProfile>>(
  (ref) => ref.watch(carProfileRepositoryProvider).watchProfiles(),
);

final workshopManualsProvider =
    StreamProvider.family<List<WorkshopManual>, int>(
      (ref, carId) =>
          ref.watch(workshopManualRepositoryProvider).watchManuals(carId),
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
    required this.workshopManualRepository,
    required this.aiBackendService,
    required this.mediaService,
    required this.reminderScheduler,
  });

  final CarProfileRepository repository;
  final WorkshopManualRepository workshopManualRepository;
  final AiBackendService aiBackendService;
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
    final manuals = await workshopManualRepository.listManuals(profile.id);
    await repository.deleteProfile(profile.id);
    await reminderScheduler.cancelForProfile(profile.id);
    await mediaService.deleteStoredFile(profile.photoPath);
    for (final manual in manuals) {
      await mediaService.deleteStoredFile(manual.localPath);
    }
  }

  Future<void> addWorkshopManuals(CarProfile profile) async {
    final pickedFiles = await mediaService.pickWorkshopManuals();
    for (final file in pickedFiles) {
      final stored = await mediaService.storeWorkshopManual(
        file,
        carProfileId: profile.id,
      );
      try {
        final uploaded = await aiBackendService.uploadManual(
          profile,
          File(stored.storedPath),
        );
        await workshopManualRepository.createManual(
          profile.id,
          WorkshopManualInput(
            backendManualId: uploaded.backendManualId,
            localPath: stored.storedPath,
            originalName: stored.originalName,
            byteSize: stored.byteSize,
          ),
        );
      } catch (_) {
        await mediaService.deleteStoredFile(stored.storedPath);
        rethrow;
      }
    }
  }

  Future<void> removeWorkshopManual(
    CarProfile profile,
    WorkshopManual manual,
  ) async {
    await aiBackendService.deleteManual(profile, manual.backendManualId);
    await workshopManualRepository.deleteManual(manual.id);
    await mediaService.deleteStoredFile(manual.localPath);
  }
}
