import 'package:carful/src/data/local/app_database.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/domain/repair_area.dart';
import 'package:carful/src/domain/repair_attachment_input.dart';
import 'package:carful/src/domain/repair_attachment_kind.dart';
import 'package:carful/src/domain/repair_entry_input.dart';
import 'package:carful/src/domain/repair_part_input.dart';
import 'package:carful/src/domain/repair_status.dart';
import 'package:carful/src/domain/repair_urgency.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late DriftCarProfileRepository carProfileRepository;
  late DriftRepairRepository repairRepository;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    carProfileRepository = DriftCarProfileRepository(database);
    repairRepository = DriftRepairRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  Future<int> createProfile() {
    return carProfileRepository.createProfile(
      CarProfileInput(
        make: 'BMW',
        model: 'E46',
        engine: '3.0L',
        firstRegistrationMonth: DateTime(2003, 4),
        vin: 'WB1234567890',
        currentMileage: 120000,
        photoPath: null,
        reminderFrequency: MileageReminderFrequency.monthly,
      ),
    );
  }

  test(
    'sorts planned repairs by urgency and completed repairs by completion date',
    () async {
      final carId = await createProfile();
      await repairRepository.createEntry(
        carId,
        const RepairEntryInput(
          status: RepairStatus.planned,
          isModification: false,
          area: RepairArea.engine,
          urgency: RepairUrgency.medium,
          title: 'Brake pad check',
          parts: [],
        ),
      );
      await repairRepository.createEntry(
        carId,
        const RepairEntryInput(
          status: RepairStatus.planned,
          isModification: false,
          area: RepairArea.engine,
          urgency: RepairUrgency.high,
          title: 'Timing belt replacement',
          parts: [],
        ),
      );
      final olderPastId = await repairRepository.createEntry(
        carId,
        RepairEntryInput(
          status: RepairStatus.completed,
          isModification: false,
          area: RepairArea.chassis,
          title: 'Control arm refresh',
          completedAt: DateTime(2024, 1, 10),
          parts: const [],
        ),
      );
      final newerPastId = await repairRepository.createEntry(
        carId,
        RepairEntryInput(
          status: RepairStatus.completed,
          isModification: false,
          area: RepairArea.body,
          title: 'Rust repair',
          completedAt: DateTime(2024, 6, 8),
          parts: const [],
        ),
      );

      final overview = await repairRepository
          .watchOverview(carId, modifications: false)
          .first;

      expect(overview.planned.map((entry) => entry.title).toList(), [
        'Timing belt replacement',
        'Brake pad check',
      ]);
      expect(overview.past.map((entry) => entry.title).toList(), [
        'Rust repair',
        'Control arm refresh',
      ]);

      final newerDetails = await repairRepository
          .watchRepairEntry(newerPastId)
          .first;
      final olderDetails = await repairRepository
          .watchRepairEntry(olderPastId)
          .first;
      expect(newerDetails!.entry.completedAt, DateTime(2024, 6, 8));
      expect(olderDetails!.entry.completedAt, DateTime(2024, 1, 10));
    },
  );

  test(
    'filters repairs and modifications separately and counts only planned repairs',
    () async {
      final carId = await createProfile();
      await repairRepository.createEntry(
        carId,
        const RepairEntryInput(
          status: RepairStatus.planned,
          isModification: false,
          area: RepairArea.engine,
          urgency: RepairUrgency.high,
          title: 'Water pump',
          parts: [],
        ),
      );
      await repairRepository.createEntry(
        carId,
        const RepairEntryInput(
          status: RepairStatus.planned,
          isModification: true,
          area: RepairArea.interior,
          urgency: RepairUrgency.low,
          title: 'Bucket seats',
          parts: [],
        ),
      );

      final repairOverview = await repairRepository
          .watchOverview(carId, modifications: false)
          .first;
      final modificationOverview = await repairRepository
          .watchOverview(carId, modifications: true)
          .first;
      final plannedCount = await repairRepository
          .watchPlannedRepairCount(carId)
          .first;

      expect(repairOverview.planned.map((entry) => entry.title), [
        'Water pump',
      ]);
      expect(modificationOverview.planned.map((entry) => entry.title), [
        'Bucket seats',
      ]);
      expect(plannedCount, 1);
    },
  );

  test('marks a planned repair as completed and can reopen it', () async {
    final carId = await createProfile();
    final entryId = await repairRepository.createEntry(
      carId,
      const RepairEntryInput(
        status: RepairStatus.planned,
        isModification: false,
        area: RepairArea.electrics,
        urgency: RepairUrgency.medium,
        title: 'Starter motor',
        parts: [],
      ),
    );

    await repairRepository.markCompleted(entryId, DateTime(2026, 4, 24));
    var details = await repairRepository.watchRepairEntry(entryId).first;
    expect(details!.entry.status, RepairStatus.completed);
    expect(details.entry.completedAt, DateTime(2026, 4, 24));

    await repairRepository.reopen(entryId);
    details = await repairRepository.watchRepairEntry(entryId).first;
    expect(details!.entry.status, RepairStatus.planned);
    expect(details.entry.completedAt, isNull);
    expect(details.entry.urgency, RepairUrgency.medium);
  });

  test(
    'updates parts, stores attachments, and cascades cleanup on delete',
    () async {
      final carId = await createProfile();
      final entryId = await repairRepository.createEntry(
        carId,
        RepairEntryInput(
          status: RepairStatus.completed,
          isModification: false,
          area: RepairArea.suspension,
          title: 'Shock absorbers',
          completedAt: DateTime(2025, 5, 3),
          parts: const [RepairPartInput(title: 'Bilstein B4 kit')],
        ),
      );

      await repairRepository.updateEntry(
        entryId,
        RepairEntryInput(
          status: RepairStatus.completed,
          isModification: false,
          area: RepairArea.suspension,
          title: 'Shock absorbers',
          description: 'Refreshed all four corners.',
          completedAt: DateTime(2025, 5, 3),
          parts: const [
            RepairPartInput(title: 'Bilstein B4 kit'),
            RepairPartInput(
              title: 'Top mounts',
              link: 'https://example.com/mounts',
            ),
          ],
        ),
      );
      await repairRepository
          .replaceExistingAttachmentSet(entryId, const [], const [
            RepairAttachmentInput(
              kind: RepairAttachmentKind.image,
              storedPath: '/stored/front.jpg',
              originalName: 'front.jpg',
              fileExtension: 'jpg',
            ),
            RepairAttachmentInput(
              kind: RepairAttachmentKind.file,
              storedPath: '/stored/invoice.pdf',
              originalName: 'invoice.pdf',
              fileExtension: 'pdf',
            ),
          ]);

      final details = await repairRepository.watchRepairEntry(entryId).first;
      expect(details, isNotNull);
      expect(details!.parts, hasLength(2));
      expect(details.attachments, hasLength(2));

      final deletedPaths = await repairRepository.deleteEntry(entryId);
      final afterDelete = await repairRepository
          .watchRepairEntry(entryId)
          .first;

      expect(deletedPaths, ['/stored/front.jpg', '/stored/invoice.pdf']);
      expect(afterDelete, isNull);
      expect(await database.select(database.repairParts).get(), isEmpty);
      expect(await database.select(database.repairAttachments).get(), isEmpty);
    },
  );
}
