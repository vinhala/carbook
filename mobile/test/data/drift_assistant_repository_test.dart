import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/data/local/drift_assistant_repository.dart';
import 'package:carful/src/domain/assistant_message.dart';
import 'package:carful/src/domain/assistant_message_source.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository carRepository;
  late DriftAssistantRepository assistantRepository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    carRepository = DriftCarProfileRepository(database);
    assistantRepository = DriftAssistantRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'round-trips structured assistant sources through local storage',
    () async {
      final carId = await carRepository.createProfile(
        CarProfileInput(
          make: 'Toyota',
          model: 'Tacoma',
          engine: '3.5L V6',
          firstRegistrationMonth: DateTime(2018, 5),
          vin: 'JT1234567890',
          currentMileage: 65240,
          photoPath: null,
          reminderFrequency: MileageReminderFrequency.monthly,
        ),
      );

      await assistantRepository.addMessage(
        carProfileId: carId,
        role: AssistantMessageRole.assistant,
        content: 'Use SAE 0W-20.',
        sources: const [
          AssistantMessageSource(
            label: 'Tacoma Manual.pdf',
            kind: 'manual',
            sourceId: 'file_manual',
            quote: 'Recommended engine oil',
          ),
          AssistantMessageSource(
            label: 'Toyota service info',
            kind: 'web',
            citation: 'Oil reference',
            url: 'https://example.com/service',
            sourceId: 'https://example.com/service',
          ),
        ],
      );

      final messages = await assistantRepository.listMessages(carId);

      expect(messages.single.content, 'Use SAE 0W-20.');
      expect(messages.single.sources, hasLength(2));
      expect(messages.single.sources.first.sourceId, 'file_manual');
      expect(messages.single.sources.first.quote, 'Recommended engine oil');
      expect(
        messages.single.sources.last.displayLabel,
        'Toyota service info • Oil reference',
      );
    },
  );
}
