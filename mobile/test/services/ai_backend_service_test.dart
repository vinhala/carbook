import 'dart:io';

import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/services/ai_backend_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('HttpAiBackendService.deleteManual', () {
    test('completes when the backend deletes the manual', () async {
      final service = HttpAiBackendService(
        client: MockClient((request) async {
          expect(request.method, 'DELETE');
          expect(request.url.path, '/cars/car_sync_1/manuals/manual_1');
          return http.Response('', 204);
        }),
      );

      await service.deleteManual(_profile(), 'manual_1');
    });

    test(
      'completes when the backend reports the manual is not found',
      () async {
        final service = HttpAiBackendService(
          client: MockClient((request) async {
            return http.Response('{"detail":"Manual not found"}', 404);
          }),
        );

        await service.deleteManual(_profile(), 'manual_1');
      },
    );

    test('throws for other backend failures', () async {
      final service = HttpAiBackendService(
        client: MockClient((request) async {
          return http.Response('boom', 500);
        }),
      );

      expect(
        service.deleteManual(_profile(), 'manual_1'),
        throwsA(isA<HttpException>()),
      );
    });
  });
}

CarProfile _profile() {
  final now = DateTime(2026, 1, 1);
  return CarProfile(
    id: 1,
    carSyncId: 'car_sync_1',
    make: 'Toyota',
    model: 'Tacoma',
    engine: '3.5L V6',
    firstRegistrationMonth: DateTime(2018, 5),
    vin: 'JT1234567890',
    currentMileage: 65000,
    mileageUnit: 'mi',
    photoPath: null,
    reminderFrequency: MileageReminderFrequency.monthly,
    lastMileageUpdatedAt: now,
    createdAt: now,
    updatedAt: now,
  );
}
