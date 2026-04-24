import 'dart:io';

import 'package:carbook/src/core/utils/date_time_utils.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/domain/car_profile_input.dart';
import 'package:carbook/src/domain/car_profile_repository.dart';
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

@DriftDatabase(tables: [CarProfiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
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
