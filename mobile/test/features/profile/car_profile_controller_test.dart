import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/data/local/drift_workshop_manual_repository.dart';
import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/domain/workshop_manual.dart';
import 'package:carful/src/domain/workshop_manual_input.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/test_doubles.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository repository;
  late DriftWorkshopManualRepository workshopManualRepository;
  late FakeAiBackendService aiBackendService;
  late FakeMediaService mediaService;
  late RecordingReminderScheduler reminderScheduler;
  late CarProfileController controller;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftCarProfileRepository(database);
    workshopManualRepository = DriftWorkshopManualRepository(database);
    aiBackendService = FakeAiBackendService();
    mediaService = FakeMediaService();
    reminderScheduler = RecordingReminderScheduler();
    controller = CarProfileController(
      repository: repository,
      workshopManualRepository: workshopManualRepository,
      aiBackendService: aiBackendService,
      mediaService: mediaService,
      reminderScheduler: reminderScheduler,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('removes a workshop manual locally after backend deletion', () async {
    final profile = await _createProfile(repository);
    final manual = await _createManual(workshopManualRepository, profile.id);

    await controller.removeWorkshopManual(profile, manual);

    expect(aiBackendService.deletedManualIds, ['manual_1']);
    expect(await workshopManualRepository.listManuals(profile.id), isEmpty);
    expect(mediaService.deletedPaths, ['/stored/manual.pdf']);
  });

  test('keeps a workshop manual locally when backend deletion fails', () async {
    final profile = await _createProfile(repository);
    final manual = await _createManual(workshopManualRepository, profile.id);
    aiBackendService.manualDeleteError = Exception('server unavailable');

    await expectLater(
      controller.removeWorkshopManual(profile, manual),
      throwsA(isA<Exception>()),
    );

    expect(aiBackendService.deletedManualIds, ['manual_1']);
    expect(
      await workshopManualRepository.listManuals(profile.id),
      hasLength(1),
    );
    expect(mediaService.deletedPaths, isEmpty);
  });
}

Future<CarProfile> _createProfile(DriftCarProfileRepository repository) async {
  final profileId = await repository.createProfile(
    CarProfileInput(
      make: 'Toyota',
      model: 'Tacoma',
      engine: '3.5L V6',
      firstRegistrationMonth: DateTime(2018, 5),
      vin: 'JT1234567890',
      currentMileage: 6500,
      photoPath: null,
      reminderFrequency: MileageReminderFrequency.monthly,
    ),
  );
  final profile = await repository.getProfile(profileId);
  return profile!;
}

Future<WorkshopManual> _createManual(
  DriftWorkshopManualRepository repository,
  int profileId,
) async {
  final manualId = await repository.createManual(
    profileId,
    const WorkshopManualInput(
      backendManualId: 'manual_1',
      localPath: '/stored/manual.pdf',
      originalName: 'Tacoma Manual.pdf',
      byteSize: 2048,
    ),
  );
  final manuals = await repository.listManuals(profileId);
  return manuals.singleWhere((manual) => manual.id == manualId);
}
