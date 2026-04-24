import 'package:carbook/src/domain/repair_entry.dart';

class RepairOverview {
  const RepairOverview({required this.planned, required this.past});

  final List<RepairEntry> planned;
  final List<RepairEntry> past;
}
