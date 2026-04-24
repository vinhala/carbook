import 'dart:io';

import 'package:carbook/src/core/utils/date_time_utils.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/car_profile_input.dart';
import 'package:carbook/src/domain/car_profile_repository.dart';
import 'package:carbook/src/domain/maintenance_due_calculator.dart';
import 'package:carbook/src/domain/maintenance_item.dart';
import 'package:carbook/src/domain/maintenance_item_details.dart';
import 'package:carbook/src/domain/maintenance_item_input.dart';
import 'package:carbook/src/domain/maintenance_log_entry.dart';
import 'package:carbook/src/domain/maintenance_log_input.dart';
import 'package:carbook/src/domain/maintenance_repository.dart';
import 'package:carbook/src/domain/maintenance_schedule_entry.dart';
import 'package:carbook/src/domain/maintenance_schedule_type.dart';
import 'package:carbook/src/domain/maintenance_time_unit.dart';
import 'package:carbook/src/domain/mileage_reminder_frequency.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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

@DataClassName('CarProfileRecord')
class CarProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
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

@DriftDatabase(tables: [CarProfiles, MaintenanceItems, MaintenanceLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

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
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'carbook.sqlite'));
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
