import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/data/local/drift_assistant_repository.dart';
import 'package:carful/src/data/local/drift_workshop_manual_repository.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/domain/workshop_manual_input.dart';
import 'package:carful/src/features/ai/ai_assistant_controller.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/test_doubles.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository carProfileRepository;
  late DriftMaintenanceRepository maintenanceRepository;
  late DriftRepairRepository repairRepository;
  late DriftWorkshopManualRepository workshopManualRepository;
  late DriftAssistantRepository assistantRepository;
  late FakeAiBackendService aiBackendService;
  late AiAssistantController controller;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    carProfileRepository = DriftCarProfileRepository(database);
    maintenanceRepository = DriftMaintenanceRepository(database);
    repairRepository = DriftRepairRepository(database);
    workshopManualRepository = DriftWorkshopManualRepository(database);
    assistantRepository = DriftAssistantRepository(database);
    aiBackendService = FakeAiBackendService();
    controller = AiAssistantController(
      carProfileRepository: carProfileRepository,
      maintenanceRepository: maintenanceRepository,
      repairRepository: repairRepository,
      workshopManualRepository: workshopManualRepository,
      assistantRepository: assistantRepository,
      aiBackendService: aiBackendService,
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('does not send messages when no workshop manuals exist', () async {
    final carId = await _createProfile(carProfileRepository);

    await expectLater(
      controller.sendMessage(carId, 'How do I change the oil?'),
      throwsA(isA<StateError>()),
    );

    expect(aiBackendService.sentMessages, isEmpty);
    expect(await assistantRepository.listMessages(carId), isEmpty);
  });

  test('sends messages when at least one workshop manual exists', () async {
    final carId = await _createProfile(carProfileRepository);
    await workshopManualRepository.createManual(
      carId,
      const WorkshopManualInput(
        backendManualId: 'manual_1',
        localPath: '/stored/manual.pdf',
        originalName: 'Tacoma Manual.pdf',
        byteSize: 2048,
      ),
    );

    await controller.sendMessage(carId, 'How do I change the oil?');

    expect(aiBackendService.sentMessages, ['How do I change the oil?']);
    final messages = await assistantRepository.listMessages(carId);
    expect(messages, hasLength(2));
    expect(messages.first.content, 'How do I change the oil?');
    expect(messages.last.content, 'Test answer');
  });
}

Future<int> _createProfile(DriftCarProfileRepository repository) {
  return repository.createProfile(
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
}
