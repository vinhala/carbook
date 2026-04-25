import 'package:carbook/src/domain/workshop_manual.dart';
import 'package:carbook/src/domain/workshop_manual_input.dart';

abstract class WorkshopManualRepository {
  Stream<List<WorkshopManual>> watchManuals(int carProfileId);
  Future<List<WorkshopManual>> listManuals(int carProfileId);
  Future<int> createManual(int carProfileId, WorkshopManualInput input);
  Future<void> deleteManual(int manualId);
}
