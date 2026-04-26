import 'dart:convert';
import 'dart:io';

import 'package:carful/src/domain/ai_schedule_suggestion.dart';
import 'package:carful/src/domain/assistant_message_source.dart';
import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/maintenance_schedule_entry.dart';
import 'package:carful/src/domain/repair_entry.dart';
import 'package:carful/src/domain/workshop_manual.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

final aiBackendServiceProvider = Provider<AiBackendService>(
  (ref) => HttpAiBackendService(),
);

class BackendManualUploadResult {
  const BackendManualUploadResult({
    required this.backendManualId,
    required this.originalName,
    required this.byteSize,
  });

  final String backendManualId;
  final String originalName;
  final int byteSize;
}

class AssistantBackendResponse {
  const AssistantBackendResponse({
    required this.status,
    required this.conversationId,
    required this.messageId,
    required this.content,
    required this.sources,
    required this.rejectionReasonCode,
    required this.usedWebSearch,
    required this.usedFileSearch,
  });

  final String status;
  final String? conversationId;
  final String messageId;
  final String content;
  final List<AssistantMessageSource> sources;
  final String? rejectionReasonCode;
  final bool usedWebSearch;
  final bool usedFileSearch;
}

abstract class AiBackendService {
  Future<void> upsertCar(CarProfile profile);
  Future<BackendManualUploadResult> uploadManual(CarProfile profile, File file);
  Future<void> deleteManual(CarProfile profile, String backendManualId);
  Future<List<AiScheduleSuggestion>> generateMaintenanceSuggestions({
    required CarProfile profile,
    required List<MaintenanceScheduleEntry> schedule,
    required List<RepairEntry> repairs,
    required List<WorkshopManual> manuals,
  });
  Future<AssistantBackendResponse> sendAssistantMessage({
    required String clientId,
    required String? conversationId,
    required String message,
    required CarProfile profile,
    required List<MaintenanceScheduleEntry> schedule,
    required List<RepairEntry> repairs,
    required List<WorkshopManual> manuals,
  });
}

class HttpAiBackendService implements AiBackendService {
  HttpAiBackendService({http.Client? client})
    : _client = client ?? http.Client(),
      _baseUri = Uri.parse(
        const String.fromEnvironment(
          'CARFUL_API_BASE_URL',
          defaultValue: 'http://api.carful.localhost',
        ),
      );

  final http.Client _client;
  final Uri _baseUri;

  @override
  Future<void> upsertCar(CarProfile profile) async {
    final response = await _client.put(
      _uri('/cars/${profile.carSyncId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'profile': _profileJson(profile)}),
    );
    _ensureSuccess(response);
  }

  @override
  Future<BackendManualUploadResult> uploadManual(
    CarProfile profile,
    File file,
  ) async {
    await upsertCar(profile);
    final request = http.MultipartRequest(
      'POST',
      _uri('/cars/${profile.carSyncId}/manuals'),
    );
    request.fields['profile_json'] = jsonEncode(_profileJson(profile));
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: p.basename(file.path),
      ),
    );
    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    _ensureSuccess(response);
    final json = jsonDecode(response.body) as Map<String, Object?>;
    return BackendManualUploadResult(
      backendManualId: json['backend_manual_id'] as String,
      originalName: json['original_name'] as String,
      byteSize: json['byte_size'] as int,
    );
  }

  @override
  Future<void> deleteManual(CarProfile profile, String backendManualId) async {
    final request =
        http.Request(
            'DELETE',
            _uri('/cars/${profile.carSyncId}/manuals/$backendManualId'),
          )
          ..headers['Content-Type'] = 'application/json'
          ..body = jsonEncode({'profile': _profileJson(profile)});
    final streamed = await _client.send(request);
    final response = await http.Response.fromStream(streamed);
    if (response.statusCode != 204 && response.statusCode != 404) {
      _ensureSuccess(response);
    }
  }

  @override
  Future<List<AiScheduleSuggestion>> generateMaintenanceSuggestions({
    required CarProfile profile,
    required List<MaintenanceScheduleEntry> schedule,
    required List<RepairEntry> repairs,
    required List<WorkshopManual> manuals,
  }) async {
    await upsertCar(profile);
    final response = await _client.post(
      _uri('/cars/${profile.carSyncId}/maintenance-suggestions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'profile': _profileJson(profile),
        'existing_items': schedule.map(_scheduleItemJson).toList(),
        'repairs': repairs.map(_repairJson).toList(),
        'manuals': manuals.map(_manualJson).toList(),
      }),
    );
    _ensureSuccess(response);
    final json = jsonDecode(response.body) as Map<String, Object?>;
    final suggestions = (json['suggestions'] as List<Object?>? ?? const [])
        .cast<Map<String, Object?>>();
    return suggestions
        .map(
          (item) => AiScheduleSuggestion(
            title: item['title'] as String? ?? '',
            description: item['description'] as String? ?? '',
            scheduleType: item['schedule_type'] as String? ?? 'distance',
            intervalValue: item['interval_value'] as int? ?? 1,
            timeUnit: item['time_unit'] as String?,
            priority: item['priority'] as String? ?? 'medium',
            manualReference: item['manual_reference'] as String?,
            selectedByDefault: item['selected_by_default'] as bool? ?? true,
          ),
        )
        .toList();
  }

  @override
  Future<AssistantBackendResponse> sendAssistantMessage({
    required String clientId,
    required String? conversationId,
    required String message,
    required CarProfile profile,
    required List<MaintenanceScheduleEntry> schedule,
    required List<RepairEntry> repairs,
    required List<WorkshopManual> manuals,
  }) async {
    await upsertCar(profile);
    final response = await _client.post(
      _uri('/cars/${profile.carSyncId}/assistant/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'client_id': clientId,
        'conversation_id': conversationId,
        'message': message,
        'profile': _profileJson(profile),
        'maintenance_items': schedule.map(_scheduleItemJson).toList(),
        'repairs': repairs.map(_repairJson).toList(),
        'manuals': manuals.map(_manualJson).toList(),
      }),
    );
    _ensureSuccess(response);
    final json = jsonDecode(response.body) as Map<String, Object?>;
    return AssistantBackendResponse(
      status: json['status'] as String? ?? 'rejected',
      conversationId: json['conversation_id'] as String?,
      messageId: json['message_id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      sources: (json['sources'] as List<Object?>? ?? const [])
          .cast<Map<String, Object?>>()
          .map(AssistantMessageSource.fromJson)
          .toList(),
      rejectionReasonCode: json['rejection_reason_code'] as String?,
      usedWebSearch: json['used_web_search'] as bool? ?? false,
      usedFileSearch: json['used_file_search'] as bool? ?? false,
    );
  }

  Uri _uri(String path) => _baseUri.replace(path: path);

  Map<String, Object?> _profileJson(CarProfile profile) => {
    'car_sync_id': profile.carSyncId,
    'display_name': profile.displayName,
    'make': profile.make,
    'model': profile.model,
    'engine': profile.engine,
    'year': profile.firstRegistrationMonth.year,
    'vin': profile.vin,
    'mileage_unit': profile.mileageUnit,
    'current_mileage': profile.currentMileage,
  };

  Map<String, Object?> _scheduleItemJson(MaintenanceScheduleEntry entry) => {
    'title': entry.item.description,
    'description': entry.item.description,
    'schedule_type': entry.item.scheduleType.storageValue,
    'interval_value': entry.item.intervalValue,
    'time_unit': entry.item.timeUnit?.storageValue,
  };

  Map<String, Object?> _repairJson(RepairEntry repair) => {
    'title': repair.title,
    'area': repair.area.storageValue,
    'status': repair.status.storageValue,
    'description': repair.description,
  };

  Map<String, Object?> _manualJson(WorkshopManual manual) => {
    'backend_manual_id': manual.backendManualId,
    'original_name': manual.originalName,
  };

  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    throw HttpException(
      'Backend request failed (${response.statusCode}). ${response.body}',
    );
  }
}
