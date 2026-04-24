import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/domain/maintenance_item_input.dart';
import 'package:carbook/src/domain/maintenance_schedule_type.dart';
import 'package:carbook/src/domain/maintenance_time_unit.dart';
import 'package:carbook/src/features/maintenance/maintenance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MaintenanceItemEditorScreen extends ConsumerStatefulWidget {
  const MaintenanceItemEditorScreen({super.key, required this.carId});

  final int? carId;

  @override
  ConsumerState<MaintenanceItemEditorScreen> createState() =>
      _MaintenanceItemEditorScreenState();
}

class _MaintenanceItemEditorScreenState
    extends ConsumerState<MaintenanceItemEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descriptionController;
  late final TextEditingController _intervalController;
  MaintenanceScheduleType _scheduleType = MaintenanceScheduleType.distance;
  MaintenanceTimeUnit _timeUnit = MaintenanceTimeUnit.months;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _intervalController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _intervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.carId == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid maintenance item.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('New Maintenance Item')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _descriptionController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Oil change',
                    ),
                    validator: _requiredValidator,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule Configurator',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SegmentedButton<MaintenanceScheduleType>(
                        segments: const [
                          ButtonSegment(
                            value: MaintenanceScheduleType.distance,
                            label: Text('Distance'),
                            icon: Icon(Icons.route_outlined),
                          ),
                          ButtonSegment(
                            value: MaintenanceScheduleType.time,
                            label: Text('Time'),
                            icon: Icon(Icons.schedule_rounded),
                          ),
                        ],
                        selected: {_scheduleType},
                        onSelectionChanged: _isSaving
                            ? null
                            : (selection) {
                                setState(() {
                                  _scheduleType = selection.first;
                                });
                              },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _intervalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText:
                              _scheduleType == MaintenanceScheduleType.distance
                              ? 'Distance interval'
                              : 'Time interval',
                          suffixText:
                              _scheduleType == MaintenanceScheduleType.distance
                              ? 'mi'
                              : null,
                        ),
                        validator: _intervalValidator,
                      ),
                      if (_scheduleType == MaintenanceScheduleType.time) ...[
                        const SizedBox(height: 16),
                        DropdownButtonFormField<MaintenanceTimeUnit>(
                          value: _timeUnit,
                          items: MaintenanceTimeUnit.values
                              .map(
                                (unit) => DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit.label),
                                ),
                              )
                              .toList(),
                          onChanged: _isSaving
                              ? null
                              : (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _timeUnit = value;
                                  });
                                },
                          decoration: const InputDecoration(
                            labelText: 'Time unit',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: FilledButton(
          onPressed: _isSaving ? null : _saveItem,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              _scheduleType == MaintenanceScheduleType.distance
                  ? 'Create Item'
                  : 'Create Time-Based Item',
            ),
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  String? _intervalValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Interval is required.';
    }

    final interval = int.tryParse(value);
    if (interval == null || interval <= 0) {
      return 'Enter a valid interval.';
    }

    return null;
  }

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final controller = ref.read(maintenanceControllerProvider);

    try {
      await controller.createItem(
        widget.carId!,
        MaintenanceItemInput(
          description: _descriptionController.text,
          scheduleType: _scheduleType,
          intervalValue: int.parse(_intervalController.text),
          timeUnit: _scheduleType == MaintenanceScheduleType.time
              ? _timeUnit
              : null,
        ),
      );

      if (!mounted) {
        return;
      }

      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/cars/${widget.carId}/maintenance');
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to create maintenance item.\n$error')),
      );
      setState(() => _isSaving = false);
    }
  }
}
