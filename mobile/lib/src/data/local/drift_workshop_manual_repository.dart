import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/workshop_manual.dart';
import 'package:carbook/src/domain/workshop_manual_input.dart';
import 'package:carbook/src/domain/workshop_manual_repository.dart';
import 'package:drift/drift.dart';

class DriftWorkshopManualRepository implements WorkshopManualRepository {
  DriftWorkshopManualRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<WorkshopManual>> watchManuals(int carProfileId) {
    final query = _database.select(_database.workshopManuals)
      ..where((table) => table.carProfileId.equals(carProfileId))
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.createdAt, mode: OrderingMode.desc),
      ]);
    return query.watch().map((rows) => rows.map(_mapRecord).toList());
  }

  @override
  Future<List<WorkshopManual>> listManuals(int carProfileId) async {
    final query = _database.select(_database.workshopManuals)
      ..where((table) => table.carProfileId.equals(carProfileId))
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.createdAt, mode: OrderingMode.desc),
      ]);
    final rows = await query.get();
    return rows.map(_mapRecord).toList();
  }

  @override
  Future<int> createManual(int carProfileId, WorkshopManualInput input) {
    final now = DateTime.now();
    return _database
        .into(_database.workshopManuals)
        .insert(
          WorkshopManualsCompanion.insert(
            carProfileId: carProfileId,
            backendManualId: input.backendManualId,
            localPath: input.localPath,
            originalName: input.originalName,
            byteSize: input.byteSize,
            createdAt: now,
          ),
        );
  }

  @override
  Future<void> deleteManual(int manualId) {
    return (_database.delete(
      _database.workshopManuals,
    )..where((table) => table.id.equals(manualId))).go();
  }

  WorkshopManual _mapRecord(WorkshopManualRecord record) {
    return WorkshopManual(
      id: record.id,
      carProfileId: record.carProfileId,
      backendManualId: record.backendManualId,
      localPath: record.localPath,
      originalName: record.originalName,
      byteSize: record.byteSize,
      createdAt: record.createdAt,
    );
  }
}
