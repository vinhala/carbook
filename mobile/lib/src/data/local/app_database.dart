import 'dart:io';

import 'package:carful/src/core/utils/date_time_utils.dart';
import 'package:carful/src/domain/assistant_repository.dart';
import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/car_profile_repository.dart';
import 'package:carful/src/domain/maintenance_due_calculator.dart';
import 'package:carful/src/domain/maintenance_item.dart';
import 'package:carful/src/domain/maintenance_item_details.dart';
import 'package:carful/src/domain/maintenance_item_input.dart';
import 'package:carful/src/domain/maintenance_log_entry.dart';
import 'package:carful/src/domain/maintenance_log_input.dart';
import 'package:carful/src/domain/maintenance_repository.dart';
import 'package:carful/src/domain/maintenance_schedule_entry.dart';
import 'package:carful/src/domain/maintenance_schedule_type.dart';
import 'package:carful/src/domain/maintenance_time_unit.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/domain/repair_area.dart';
import 'package:carful/src/domain/repair_attachment.dart';
import 'package:carful/src/domain/repair_attachment_input.dart';
import 'package:carful/src/domain/repair_attachment_kind.dart';
import 'package:carful/src/domain/repair_entry.dart';
import 'package:carful/src/domain/repair_entry_details.dart';
import 'package:carful/src/domain/repair_entry_input.dart';
import 'package:carful/src/domain/repair_overview.dart';
import 'package:carful/src/domain/repair_part.dart';
import 'package:carful/src/domain/repair_part_input.dart';
import 'package:carful/src/domain/repair_repository.dart';
import 'package:carful/src/domain/repair_status.dart';
import 'package:carful/src/domain/repair_urgency.dart';
import 'package:carful/src/domain/workshop_manual_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

class MileageReminderFrequencyConverter
    extends TypeConverter<MileageReminderFrequency, String> {
  const MileageReminderFrequencyConverter();

  @override
  MileageReminderFrequency fromSql(String fromDb) =>
      MileageReminderFrequency.fromStorage(fromDb);

  @override
  String toSql(MileageReminderFrequency value) => value.storageValue;
}

class MaintenanceScheduleTypeConverter
    extends TypeConverter<MaintenanceScheduleType, String> {
  const MaintenanceScheduleTypeConverter();

  @override
  MaintenanceScheduleType fromSql(String fromDb) =>
      MaintenanceScheduleType.fromStorage(fromDb);

  @override
  String toSql(MaintenanceScheduleType value) => value.storageValue;
}

class NullableMaintenanceTimeUnitConverter
    extends TypeConverter<MaintenanceTimeUnit?, String?> {
  const NullableMaintenanceTimeUnitConverter();

  @override
  MaintenanceTimeUnit? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return MaintenanceTimeUnit.fromStorage(fromDb);
  }

  @override
  String? toSql(MaintenanceTimeUnit? value) => value?.storageValue;
}

class RepairStatusConverter extends TypeConverter<RepairStatus, String> {
  const RepairStatusConverter();

  @override
  RepairStatus fromSql(String fromDb) => RepairStatus.fromStorage(fromDb);

  @override
  String toSql(RepairStatus value) => value.storageValue;
}

class RepairAreaConverter extends TypeConverter<RepairArea, String> {
  const RepairAreaConverter();

  @override
  RepairArea fromSql(String fromDb) => RepairArea.fromStorage(fromDb);

  @override
  String toSql(RepairArea value) => value.storageValue;
}

class NullableRepairUrgencyConverter
    extends TypeConverter<RepairUrgency?, String?> {
  const NullableRepairUrgencyConverter();

  @override
  RepairUrgency? fromSql(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return RepairUrgency.fromStorage(fromDb);
  }

  @override
  String? toSql(RepairUrgency? value) => value?.storageValue;
}

class RepairAttachmentKindConverter
    extends TypeConverter<RepairAttachmentKind, String> {
  const RepairAttachmentKindConverter();

  @override
  RepairAttachmentKind fromSql(String fromDb) =>
      RepairAttachmentKind.fromStorage(fromDb);

  @override
  String toSql(RepairAttachmentKind value) => value.storageValue;
}

@DataClassName('CarProfileRecord')
class CarProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get carSyncId => text().withDefault(const Constant(''))();
  TextColumn get make => text()();
  TextColumn get model => text()();
  TextColumn get engine => text()();
  DateTimeColumn get firstRegistrationMonth => dateTime()();
  TextColumn get vin => text()();
  IntColumn get currentMileage => integer()();
  TextColumn get mileageUnit => text().withDefault(const Constant('mi'))();
  TextColumn get photoPath => text().nullable()();
  TextColumn get reminderFrequency =>
      text().map(const MileageReminderFrequencyConverter())();
  DateTimeColumn get lastMileageUpdatedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('MaintenanceItemRecord')
class MaintenanceItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get carProfileId =>
      integer().references(CarProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get description => text()();
  TextColumn get scheduleType =>
      text().map(const MaintenanceScheduleTypeConverter())();
  IntColumn get intervalValue => integer()();
  TextColumn get timeUnit =>
      text().nullable().map(const NullableMaintenanceTimeUnitConverter())();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('MaintenanceLogRecord')
class MaintenanceLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get maintenanceItemId => integer().references(
    MaintenanceItems,
    #id,
    onDelete: KeyAction.cascade,
  )();
  DateTimeColumn get performedAt => dateTime()();
  IntColumn get mileage => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('RepairEntryRecord')
class RepairEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get carProfileId =>
      integer().references(CarProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => text().map(const RepairStatusConverter())();
  BoolColumn get isModification => boolean()();
  TextColumn get area => text().map(const RepairAreaConverter())();
  TextColumn get urgency =>
      text().nullable().map(const NullableRepairUrgencyConverter())();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('RepairPartRecord')
class RepairParts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get repairEntryId =>
      integer().references(RepairEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get link => text().nullable()();
}

@DataClassName('RepairAttachmentRecord')
class RepairAttachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get repairEntryId =>
      integer().references(RepairEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text().map(const RepairAttachmentKindConverter())();
  TextColumn get storedPath => text()();
  TextColumn get originalName => text()();
  TextColumn get mimeType => text().nullable()();
  TextColumn get fileExtension => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('WorkshopManualRecord')
class WorkshopManuals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get carProfileId =>
      integer().references(CarProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get backendManualId => text()();
  TextColumn get localPath => text()();
  TextColumn get originalName => text()();
  IntColumn get byteSize => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('AssistantConversationRecord')
class AssistantConversations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get carProfileId =>
      integer().references(CarProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get conversationId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DataClassName('AssistantMessageRecord')
class AssistantMessages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get carProfileId =>
      integer().references(CarProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get role => text()();
  TextColumn get content => text()();
  TextColumn get backendMessageId => text().nullable()();
  TextColumn get rejectionReasonCode => text().nullable()();
  TextColumn get sourcesJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(
  tables: [
    CarProfiles,
    MaintenanceItems,
    MaintenanceLogs,
    RepairEntries,
    RepairParts,
    RepairAttachments,
    WorkshopManuals,
    AssistantConversations,
    AssistantMessages,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(maintenanceItems);
        await migrator.createTable(maintenanceLogs);
      }
      if (from < 3) {
        await migrator.createTable(repairEntries);
        await migrator.createTable(repairParts);
        await migrator.createTable(repairAttachments);
      }
      if (from < 4) {
        await migrator.addColumn(carProfiles, carProfiles.carSyncId);
        await migrator.createTable(workshopManuals);
        await migrator.createTable(assistantConversations);
        await migrator.createTable(assistantMessages);
        final rows = await customSelect('SELECT id FROM car_profiles').get();
        const uuid = Uuid();
        for (final row in rows) {
          final id = row.read<int>('id');
          await customStatement(
            'UPDATE car_profiles SET car_sync_id = ? WHERE id = ?',
            [uuid.v4(), id],
          );
        }
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'carful.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

final appDatabaseProvider = Provider<AppDatabase>(
  (ref) =>
      throw UnimplementedError('AppDatabase must be overridden at startup.'),
);

final carProfileRepositoryProvider = Provider<CarProfileRepository>(
  (ref) => throw UnimplementedError(
    'CarProfileRepository must be overridden at startup.',
  ),
);

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>(
  (ref) => throw UnimplementedError(
    'MaintenanceRepository must be overridden at startup.',
  ),
);

final repairRepositoryProvider = Provider<RepairRepository>(
  (ref) => throw UnimplementedError(
    'RepairRepository must be overridden at startup.',
  ),
);

final workshopManualRepositoryProvider = Provider<WorkshopManualRepository>(
  (ref) => throw UnimplementedError(
    'WorkshopManualRepository must be overridden at startup.',
  ),
);

final assistantRepositoryProvider = Provider<AssistantRepository>(
  (ref) => throw UnimplementedError(
    'AssistantRepository must be overridden at startup.',
  ),
);

class DriftCarProfileRepository implements CarProfileRepository {
  DriftCarProfileRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<CarProfile>> watchProfiles() {
    final query = _database.select(_database.carProfiles)
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.updatedAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map(_mapRecord).toList());
  }

  @override
  Future<CarProfile?> getProfile(int id) async {
    final query = _database.select(_database.carProfiles)
      ..where((table) => table.id.equals(id));
    final record = await query.getSingleOrNull();
    return record == null ? null : _mapRecord(record);
  }

  @override
  Future<int> createProfile(CarProfileInput input) {
    final now = DateTime.now();
    return _database
        .into(_database.carProfiles)
        .insert(
          CarProfilesCompanion.insert(
            carSyncId: Value(const Uuid().v4()),
            make: input.make.trim(),
            model: input.model.trim(),
            engine: input.engine.trim(),
            firstRegistrationMonth: beginningOfMonth(
              input.firstRegistrationMonth,
            ),
            vin: input.vin.trim(),
            currentMileage: input.currentMileage,
            mileageUnit: Value(input.mileageUnit),
            photoPath: Value(input.photoPath),
            reminderFrequency: input.reminderFrequency,
            lastMileageUpdatedAt: now,
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> updateProfile(int id, CarProfileInput input) async {
    final existing = await getProfile(id);
    if (existing == null) {
      return;
    }

    final now = DateTime.now();
    final mileageChanged = existing.currentMileage != input.currentMileage;

    await (_database.update(
      _database.carProfiles,
    )..where((table) => table.id.equals(id))).write(
      CarProfilesCompanion(
        make: Value(input.make.trim()),
        model: Value(input.model.trim()),
        engine: Value(input.engine.trim()),
        firstRegistrationMonth: Value(
          beginningOfMonth(input.firstRegistrationMonth),
        ),
        vin: Value(input.vin.trim()),
        currentMileage: Value(input.currentMileage),
        mileageUnit: Value(input.mileageUnit),
        photoPath: Value(input.photoPath),
        reminderFrequency: Value(input.reminderFrequency),
        lastMileageUpdatedAt: Value(
          mileageChanged ? now : existing.lastMileageUpdatedAt,
        ),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> deleteProfile(int id) {
    return (_database.delete(
      _database.carProfiles,
    )..where((table) => table.id.equals(id))).go();
  }

  @override
  Future<void> updateMileage(int id, int mileage, DateTime updatedAt) {
    return (_database.update(
      _database.carProfiles,
    )..where((table) => table.id.equals(id))).write(
      CarProfilesCompanion(
        currentMileage: Value(mileage),
        lastMileageUpdatedAt: Value(updatedAt),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  CarProfile _mapRecord(CarProfileRecord record) {
    return CarProfile(
      id: record.id,
      carSyncId: record.carSyncId,
      make: record.make,
      model: record.model,
      engine: record.engine,
      firstRegistrationMonth: record.firstRegistrationMonth,
      vin: record.vin,
      currentMileage: record.currentMileage,
      mileageUnit: record.mileageUnit,
      photoPath: record.photoPath,
      reminderFrequency: record.reminderFrequency,
      lastMileageUpdatedAt: record.lastMileageUpdatedAt,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    );
  }
}

class DriftMaintenanceRepository implements MaintenanceRepository {
  DriftMaintenanceRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<MaintenanceScheduleEntry>> watchSchedule(int carProfileId) {
    final query = _database.select(_database.maintenanceItems).join([
      innerJoin(
        _database.carProfiles,
        _database.carProfiles.id.equalsExp(
          _database.maintenanceItems.carProfileId,
        ),
      ),
    ])..where(_database.maintenanceItems.carProfileId.equals(carProfileId));

    return query.watch().asyncMap((rows) async {
      final entries = <MaintenanceScheduleEntry>[];

      for (final row in rows) {
        final item = _mapMaintenanceItem(
          row.readTable(_database.maintenanceItems),
        );
        final profile = _mapCarProfile(row.readTable(_database.carProfiles));
        final logs = await _fetchLogsForItem(item.id);
        final dueStatus = buildMaintenanceDueStatus(
          profile: profile,
          item: item,
          logs: logs,
        );
        entries.add(MaintenanceScheduleEntry(item: item, dueStatus: dueStatus));
      }

      entries.sort(_compareScheduleEntries);
      return entries;
    });
  }

  @override
  Stream<MaintenanceItemDetails?> watchMaintenanceItem(int itemId) {
    final query = _database.select(_database.maintenanceItems).join([
      innerJoin(
        _database.carProfiles,
        _database.carProfiles.id.equalsExp(
          _database.maintenanceItems.carProfileId,
        ),
      ),
    ])..where(_database.maintenanceItems.id.equals(itemId));

    return query.watch().asyncMap((rows) async {
      if (rows.isEmpty) {
        return null;
      }

      final row = rows.single;
      final item = _mapMaintenanceItem(
        row.readTable(_database.maintenanceItems),
      );
      final profile = _mapCarProfile(row.readTable(_database.carProfiles));
      final logs = await _fetchLogsForItem(item.id);

      return MaintenanceItemDetails(
        item: item,
        dueStatus: buildMaintenanceDueStatus(
          profile: profile,
          item: item,
          logs: logs,
        ),
        logs: logs,
      );
    });
  }

  @override
  Future<int> createItem(int carProfileId, MaintenanceItemInput input) {
    final now = DateTime.now();
    return _database
        .into(_database.maintenanceItems)
        .insert(
          MaintenanceItemsCompanion.insert(
            carProfileId: carProfileId,
            description: input.description.trim(),
            scheduleType: input.scheduleType,
            intervalValue: input.intervalValue,
            timeUnit: Value(
              input.scheduleType == MaintenanceScheduleType.time
                  ? input.timeUnit
                  : null,
            ),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> updateItem(int itemId, MaintenanceItemInput input) {
    final now = DateTime.now();
    return (_database.update(
      _database.maintenanceItems,
    )..where((table) => table.id.equals(itemId))).write(
      MaintenanceItemsCompanion(
        description: Value(input.description.trim()),
        scheduleType: Value(input.scheduleType),
        intervalValue: Value(input.intervalValue),
        timeUnit: Value(
          input.scheduleType == MaintenanceScheduleType.time
              ? input.timeUnit
              : null,
        ),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> deleteItem(int itemId) {
    return _database.transaction(() async {
      await (_database.delete(
        _database.maintenanceLogs,
      )..where((table) => table.maintenanceItemId.equals(itemId))).go();
      await (_database.delete(
        _database.maintenanceItems,
      )..where((table) => table.id.equals(itemId))).go();
    });
  }

  @override
  Future<void> addPerformedWork(int itemId, MaintenanceLogInput input) async {
    await _database.transaction(() async {
      final itemQuery = _database.select(_database.maintenanceItems)
        ..where((table) => table.id.equals(itemId));
      final item = await itemQuery.getSingleOrNull();
      if (item == null) {
        return;
      }

      final now = DateTime.now();

      await _database
          .into(_database.maintenanceLogs)
          .insert(
            MaintenanceLogsCompanion.insert(
              maintenanceItemId: itemId,
              performedAt: input.performedAt,
              mileage: input.mileage,
              note: Value(
                input.note?.trim().isEmpty ?? true ? null : input.note!.trim(),
              ),
              createdAt: now,
            ),
          );

      await (_database.update(_database.maintenanceItems)
            ..where((table) => table.id.equals(itemId)))
          .write(MaintenanceItemsCompanion(updatedAt: Value(now)));

      final profileQuery = _database.select(_database.carProfiles)
        ..where((table) => table.id.equals(item.carProfileId));
      final profile = await profileQuery.getSingleOrNull();
      if (profile == null || input.mileage <= profile.currentMileage) {
        return;
      }

      await (_database.update(
        _database.carProfiles,
      )..where((table) => table.id.equals(profile.id))).write(
        CarProfilesCompanion(
          currentMileage: Value(input.mileage),
          lastMileageUpdatedAt: Value(input.performedAt),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<List<MaintenanceLogEntry>> _fetchLogsForItem(int itemId) async {
    final query = _database.select(_database.maintenanceLogs)
      ..where((table) => table.maintenanceItemId.equals(itemId))
      ..orderBy([
        (table) => OrderingTerm(
          expression: table.performedAt,
          mode: OrderingMode.desc,
        ),
        (table) => OrderingTerm(expression: table.id, mode: OrderingMode.desc),
      ]);

    final rows = await query.get();
    return rows.map(_mapMaintenanceLog).toList();
  }

  MaintenanceItem _mapMaintenanceItem(MaintenanceItemRecord record) {
    return MaintenanceItem(
      id: record.id,
      carProfileId: record.carProfileId,
      description: record.description,
      scheduleType: record.scheduleType,
      intervalValue: record.intervalValue,
      timeUnit: record.timeUnit,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    );
  }

  MaintenanceLogEntry _mapMaintenanceLog(MaintenanceLogRecord record) {
    return MaintenanceLogEntry(
      id: record.id,
      maintenanceItemId: record.maintenanceItemId,
      performedAt: record.performedAt,
      mileage: record.mileage,
      note: record.note,
      createdAt: record.createdAt,
    );
  }

  CarProfile _mapCarProfile(CarProfileRecord record) {
    return CarProfile(
      id: record.id,
      carSyncId: record.carSyncId,
      make: record.make,
      model: record.model,
      engine: record.engine,
      firstRegistrationMonth: record.firstRegistrationMonth,
      vin: record.vin,
      currentMileage: record.currentMileage,
      mileageUnit: record.mileageUnit,
      photoPath: record.photoPath,
      reminderFrequency: record.reminderFrequency,
      lastMileageUpdatedAt: record.lastMileageUpdatedAt,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    );
  }

  int _compareScheduleEntries(
    MaintenanceScheduleEntry left,
    MaintenanceScheduleEntry right,
  ) {
    if (left.dueStatus.isOverdue != right.dueStatus.isOverdue) {
      return left.dueStatus.isOverdue ? -1 : 1;
    }

    if (left.item.isDistanceBased != right.item.isDistanceBased) {
      return left.item.isDistanceBased ? -1 : 1;
    }

    if (left.item.isDistanceBased) {
      if (left.dueStatus.isOverdue) {
        final rightOverdue = right.dueStatus.overdueMileage ?? 0;
        final leftOverdue = left.dueStatus.overdueMileage ?? 0;
        return rightOverdue.compareTo(leftOverdue);
      }

      final leftRemaining = left.dueStatus.remainingMileage ?? 0;
      final rightRemaining = right.dueStatus.remainingMileage ?? 0;
      return leftRemaining.compareTo(rightRemaining);
    }

    if (left.dueStatus.isOverdue) {
      final rightOverdue = right.dueStatus.overdueDays ?? 0;
      final leftOverdue = left.dueStatus.overdueDays ?? 0;
      return rightOverdue.compareTo(leftOverdue);
    }

    final leftRemaining = left.dueStatus.remainingDays ?? 0;
    final rightRemaining = right.dueStatus.remainingDays ?? 0;
    final byRemaining = leftRemaining.compareTo(rightRemaining);
    if (byRemaining != 0) {
      return byRemaining;
    }

    return left.item.description.compareTo(right.item.description);
  }
}

class DriftRepairRepository implements RepairRepository {
  DriftRepairRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<RepairOverview> watchOverview(
    int carProfileId, {
    required bool modifications,
  }) {
    final query = _database.select(_database.repairEntries)
      ..where((table) => table.carProfileId.equals(carProfileId))
      ..where((table) => table.isModification.equals(modifications));

    return query.watch().map((rows) {
      final entries = rows.map(_mapRepairEntry).toList();
      final planned = entries.where((entry) => entry.isPlanned).toList()
        ..sort(_comparePlannedEntries);
      final past = entries.where((entry) => entry.isCompleted).toList()
        ..sort(_comparePastEntries);
      return RepairOverview(planned: planned, past: past);
    });
  }

  @override
  Stream<RepairEntryDetails?> watchRepairEntry(int entryId) {
    final query = _database.select(_database.repairEntries)
      ..where((table) => table.id.equals(entryId));

    return query.watch().asyncMap((rows) async {
      if (rows.isEmpty) {
        return null;
      }

      final record = rows.single;
      return RepairEntryDetails(
        entry: _mapRepairEntry(record),
        parts: await _fetchPartsForEntry(entryId),
        attachments: await _fetchAttachmentsForEntry(entryId),
      );
    });
  }

  @override
  Stream<int> watchPlannedRepairCount(int carProfileId) {
    final query = _database.select(_database.repairEntries)
      ..where((table) => table.carProfileId.equals(carProfileId))
      ..where((table) => table.status.equals(RepairStatus.planned.storageValue))
      ..where((table) => table.isModification.equals(false));

    return query.watch().map((rows) => rows.length);
  }

  @override
  Future<int> createEntry(int carProfileId, RepairEntryInput input) async {
    return _database.transaction(() async {
      final entryId = await _database
          .into(_database.repairEntries)
          .insert(
            _buildRepairEntryCompanion(input, carProfileId: carProfileId),
          );
      await _replaceParts(entryId, input.parts);
      return entryId;
    });
  }

  @override
  Future<void> updateEntry(int entryId, RepairEntryInput input) async {
    await _database.transaction(() async {
      final now = DateTime.now();
      await (_database.update(
        _database.repairEntries,
      )..where((table) => table.id.equals(entryId))).write(
        RepairEntriesCompanion(
          status: Value(input.status),
          isModification: Value(input.isModification),
          area: Value(input.area),
          urgency: Value(input.urgency),
          title: Value(input.title.trim()),
          description: Value(_normalizeOptionalText(input.description)),
          completedAt: Value(input.completedAt),
          updatedAt: Value(now),
        ),
      );
      await _replaceParts(entryId, input.parts);
    });
  }

  @override
  Future<void> replaceAttachments(
    int entryId,
    List<RepairAttachmentInput> attachments,
  ) async {
    await _database.transaction(() async {
      await (_database.delete(
        _database.repairAttachments,
      )..where((table) => table.repairEntryId.equals(entryId))).go();
      await _insertAttachments(entryId, attachments);
    });
  }

  @override
  Future<List<String>> replaceExistingAttachmentSet(
    int entryId,
    List<int> retainedAttachmentIds,
    List<RepairAttachmentInput> newAttachments,
  ) async {
    return _database.transaction(() async {
      final current = await (_database.select(
        _database.repairAttachments,
      )..where((table) => table.repairEntryId.equals(entryId))).get();

      final removed = current
          .where((attachment) => !retainedAttachmentIds.contains(attachment.id))
          .toList();

      if (removed.isNotEmpty) {
        await (_database.delete(_database.repairAttachments)
              ..where((table) => table.id.isIn(removed.map((item) => item.id))))
            .go();
      }

      await _insertAttachments(entryId, newAttachments);
      return removed.map((item) => item.storedPath).toList();
    });
  }

  @override
  Future<List<String>> deleteEntry(int entryId) async {
    return _database.transaction(() async {
      final attachments = await (_database.select(
        _database.repairAttachments,
      )..where((table) => table.repairEntryId.equals(entryId))).get();
      await (_database.delete(
        _database.repairParts,
      )..where((table) => table.repairEntryId.equals(entryId))).go();
      await (_database.delete(
        _database.repairAttachments,
      )..where((table) => table.repairEntryId.equals(entryId))).go();
      await (_database.delete(
        _database.repairEntries,
      )..where((table) => table.id.equals(entryId))).go();
      return attachments.map((item) => item.storedPath).toList();
    });
  }

  @override
  Future<void> markCompleted(int entryId, DateTime completedAt) {
    return (_database.update(
      _database.repairEntries,
    )..where((table) => table.id.equals(entryId))).write(
      RepairEntriesCompanion(
        status: const Value(RepairStatus.completed),
        completedAt: Value(completedAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> reopen(int entryId) async {
    final query = _database.select(_database.repairEntries)
      ..where((table) => table.id.equals(entryId));
    final existing = await query.getSingleOrNull();
    if (existing == null) {
      return;
    }

    await (_database.update(
      _database.repairEntries,
    )..where((table) => table.id.equals(entryId))).write(
      RepairEntriesCompanion(
        status: const Value(RepairStatus.planned),
        urgency: Value(existing.urgency ?? RepairUrgency.medium),
        completedAt: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  RepairEntriesCompanion _buildRepairEntryCompanion(
    RepairEntryInput input, {
    required int carProfileId,
  }) {
    final now = DateTime.now();
    return RepairEntriesCompanion.insert(
      carProfileId: carProfileId,
      status: input.status,
      isModification: input.isModification,
      area: input.area,
      urgency: Value(input.urgency),
      title: input.title.trim(),
      description: Value(_normalizeOptionalText(input.description)),
      completedAt: Value(input.completedAt),
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<void> _replaceParts(int entryId, List<RepairPartInput> parts) async {
    await (_database.delete(
      _database.repairParts,
    )..where((table) => table.repairEntryId.equals(entryId))).go();

    if (parts.isEmpty) {
      return;
    }

    await _database.batch((batch) {
      batch.insertAll(
        _database.repairParts,
        parts
            .map(
              (part) => RepairPartsCompanion.insert(
                repairEntryId: entryId,
                title: part.title.trim(),
                link: Value(_normalizeOptionalText(part.link)),
              ),
            )
            .toList(),
      );
    });
  }

  Future<void> _insertAttachments(
    int entryId,
    List<RepairAttachmentInput> attachments,
  ) async {
    if (attachments.isEmpty) {
      return;
    }

    final now = DateTime.now();
    await _database.batch((batch) {
      batch.insertAll(
        _database.repairAttachments,
        attachments
            .map(
              (attachment) => RepairAttachmentsCompanion.insert(
                repairEntryId: entryId,
                kind: attachment.kind,
                storedPath: attachment.storedPath,
                originalName: attachment.originalName,
                mimeType: Value(attachment.mimeType),
                fileExtension: Value(attachment.fileExtension),
                createdAt: now,
              ),
            )
            .toList(),
      );
    });
  }

  Future<List<RepairPart>> _fetchPartsForEntry(int entryId) async {
    final rows =
        await (_database.select(_database.repairParts)
              ..where((table) => table.repairEntryId.equals(entryId))
              ..orderBy([
                (table) =>
                    OrderingTerm(expression: table.id, mode: OrderingMode.asc),
              ]))
            .get();
    return rows.map(_mapRepairPart).toList();
  }

  Future<List<RepairAttachment>> _fetchAttachmentsForEntry(int entryId) async {
    final rows =
        await (_database.select(_database.repairAttachments)
              ..where((table) => table.repairEntryId.equals(entryId))
              ..orderBy([
                (table) =>
                    OrderingTerm(expression: table.id, mode: OrderingMode.asc),
              ]))
            .get();
    return rows.map(_mapRepairAttachment).toList();
  }

  RepairEntry _mapRepairEntry(RepairEntryRecord record) {
    return RepairEntry(
      id: record.id,
      carProfileId: record.carProfileId,
      status: record.status,
      isModification: record.isModification,
      area: record.area,
      urgency: record.urgency,
      title: record.title,
      description: record.description,
      completedAt: record.completedAt,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    );
  }

  RepairPart _mapRepairPart(RepairPartRecord record) {
    return RepairPart(
      id: record.id,
      repairEntryId: record.repairEntryId,
      title: record.title,
      link: record.link,
    );
  }

  RepairAttachment _mapRepairAttachment(RepairAttachmentRecord record) {
    return RepairAttachment(
      id: record.id,
      repairEntryId: record.repairEntryId,
      kind: record.kind,
      storedPath: record.storedPath,
      originalName: record.originalName,
      mimeType: record.mimeType,
      fileExtension: record.fileExtension,
      createdAt: record.createdAt,
    );
  }

  int _comparePlannedEntries(RepairEntry left, RepairEntry right) {
    final byUrgency = (right.urgency?.priority ?? 0).compareTo(
      left.urgency?.priority ?? 0,
    );
    if (byUrgency != 0) {
      return byUrgency;
    }

    final byUpdated = right.updatedAt.compareTo(left.updatedAt);
    if (byUpdated != 0) {
      return byUpdated;
    }

    return left.title.compareTo(right.title);
  }

  int _comparePastEntries(RepairEntry left, RepairEntry right) {
    final leftCompleted = left.completedAt ?? left.updatedAt;
    final rightCompleted = right.completedAt ?? right.updatedAt;
    final byCompleted = rightCompleted.compareTo(leftCompleted);
    if (byCompleted != 0) {
      return byCompleted;
    }

    return left.title.compareTo(right.title);
  }

  String? _normalizeOptionalText(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
