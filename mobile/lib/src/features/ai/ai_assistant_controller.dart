import 'dart:ui' as ui;

import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/domain/ai_schedule_suggestion.dart';
import 'package:carful/src/domain/assistant_message.dart';
import 'package:carful/src/domain/assistant_repository.dart';
import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/car_profile_repository.dart';
import 'package:carful/src/domain/maintenance_repository.dart';
import 'package:carful/src/domain/maintenance_schedule_entry.dart';
import 'package:carful/src/domain/repair_entry.dart';
import 'package:carful/src/domain/repair_repository.dart';
import 'package:carful/src/domain/workshop_manual.dart';
import 'package:carful/src/domain/workshop_manual_repository.dart';
import 'package:carful/src/services/ai_backend_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiAssistantControllerProvider = Provider<AiAssistantController>(
  (ref) => AiAssistantController(
    carProfileRepository: ref.watch(carProfileRepositoryProvider),
    maintenanceRepository: ref.watch(maintenanceRepositoryProvider),
    repairRepository: ref.watch(repairRepositoryProvider),
    workshopManualRepository: ref.watch(workshopManualRepositoryProvider),
    assistantRepository: ref.watch(assistantRepositoryProvider),
    aiBackendService: ref.watch(aiBackendServiceProvider),
  ),
);

final assistantMessagesProvider =
    StreamProvider.family<List<AssistantMessage>, int>(
      (ref, carId) =>
          ref.watch(assistantRepositoryProvider).watchMessages(carId),
    );

final maintenanceSuggestionsProvider =
    FutureProvider.family<List<AiScheduleSuggestion>, int>((ref, carId) {
      return ref
          .read(aiAssistantControllerProvider)
          .generateScheduleSuggestions(carId);
    });

class AiAssistantController {
  const AiAssistantController({
    required this.carProfileRepository,
    required this.maintenanceRepository,
    required this.repairRepository,
    required this.workshopManualRepository,
    required this.assistantRepository,
    required this.aiBackendService,
  });

  final CarProfileRepository carProfileRepository;
  final MaintenanceRepository maintenanceRepository;
  final RepairRepository repairRepository;
  final WorkshopManualRepository workshopManualRepository;
  final AssistantRepository assistantRepository;
  final AiBackendService aiBackendService;

  Future<List<AiScheduleSuggestion>> generateScheduleSuggestions(
    int carId,
  ) async {
    final context = await _loadContext(carId);
    return aiBackendService.generateMaintenanceSuggestions(
      locale: _deviceLocale(),
      profile: context.profile,
      schedule: context.schedule,
      repairs: context.repairs,
      manuals: context.manuals,
    );
  }

  Future<void> applySuggestions(
    int carId,
    List<AiScheduleSuggestion> suggestions,
  ) async {
    for (final suggestion in suggestions) {
      await maintenanceRepository.createItem(
        carId,
        suggestion.toMaintenanceItemInput(),
      );
    }
  }

  Future<void> sendMessage(int carId, String message) async {
    final trimmed = message.trim();
    if (trimmed.isEmpty) {
      return;
    }

    final manuals = await workshopManualRepository.listManuals(carId);
    if (manuals.isEmpty) {
      throw StateError(
        'Add at least one workshop manual to start using the assistant.',
      );
    }

    await assistantRepository.addMessage(
      carProfileId: carId,
      role: AssistantMessageRole.user,
      content: trimmed,
    );

    final context = await _loadContext(carId);
    final conversationId = await assistantRepository.getConversationId(carId);
    final response = await aiBackendService.sendAssistantMessage(
      clientId: 'carful-$carId',
      locale: _deviceLocale(),
      conversationId: conversationId,
      message: trimmed,
      profile: context.profile,
      schedule: context.schedule,
      repairs: context.repairs,
      manuals: context.manuals,
    );

    await assistantRepository.saveConversationId(
      carId,
      response.conversationId,
    );
    await assistantRepository.addMessage(
      carProfileId: carId,
      role: AssistantMessageRole.assistant,
      content: response.content,
      backendMessageId: response.messageId,
      rejectionReasonCode: response.rejectionReasonCode,
      sources: response.sources,
    );
  }

  Future<_AiContext> _loadContext(int carId) async {
    final profile = await carProfileRepository.getProfile(carId);
    if (profile == null) {
      throw StateError('Unable to load car profile.');
    }

    final schedule = await maintenanceRepository.watchSchedule(carId).first;
    final repairs = await _loadRepairs(carId);
    final manuals = await workshopManualRepository.listManuals(carId);

    return _AiContext(
      profile: profile,
      schedule: schedule,
      repairs: repairs,
      manuals: manuals,
    );
  }

  String _deviceLocale() =>
      ui.PlatformDispatcher.instance.locale.toLanguageTag();

  Future<List<RepairEntry>> _loadRepairs(int carId) async {
    final repairs = await repairRepository
        .watchOverview(carId, modifications: false)
        .first;
    final modifications = await repairRepository
        .watchOverview(carId, modifications: true)
        .first;
    return [
      ...repairs.planned,
      ...repairs.past,
      ...modifications.planned,
      ...modifications.past,
    ];
  }
}

class _AiContext {
  const _AiContext({
    required this.profile,
    required this.schedule,
    required this.repairs,
    required this.manuals,
  });

  final CarProfile profile;
  final List<MaintenanceScheduleEntry> schedule;
  final List<RepairEntry> repairs;
  final List<WorkshopManual> manuals;
}
