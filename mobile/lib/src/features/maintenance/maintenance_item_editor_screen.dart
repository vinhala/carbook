import 'package:carful/src/domain/maintenance_item_details.dart';
import 'package:carful/src/domain/maintenance_item_input.dart';
import 'package:carful/src/domain/maintenance_schedule_type.dart';
import 'package:carful/src/domain/maintenance_time_unit.dart';
import 'package:carful/src/features/maintenance/maintenance_controller.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MaintenanceItemEditorScreen extends ConsumerStatefulWidget {
  const MaintenanceItemEditorScreen({
    super.key,
    required this.carId,
    this.itemId,
  });

  final int? carId;
  final int? itemId;

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
  bool _didHydrate = false;

  bool get _isEditing => widget.itemId != null;

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
    if (widget.carId == null || (_isEditing && widget.itemId == null)) {
      return const Scaffold(
        body: Center(child: Text('Invalid maintenance item.')),
      );
    }

    final mileageUnit =
        ref
            .watch(carProfileProvider(widget.carId!))
            .asData
            ?.value
            ?.mileageUnit ??
        'mi';

    final detailsAsync = _isEditing
        ? ref.watch(maintenanceItemProvider(widget.itemId!))
        : const AsyncValue<MaintenanceItemDetails?>.data(null);

    return detailsAsync.when(
      data: (details) {
        if (_isEditing && details == null) {
          return const Scaffold(
            body: Center(
              child: Text('This maintenance item could not be found.'),
            ),
          );
        }

        if (details != null && !_didHydrate) {
          _hydrate(details);
        }

        return _buildScaffold(context, mileageUnit, details);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Unable to load maintenance item.\n$error'),
          ),
        ),
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    String mileageUnit,
    MaintenanceItemDetails? details,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Maintenance Item' : 'New Maintenance Item',
        ),
      ),
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
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<MaintenanceScheduleType>(
                          expandedInsets: EdgeInsets.zero,
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
                              ? mileageUnit
                              : null,
                        ),
                        validator: _intervalValidator,
                      ),
                      if (_scheduleType == MaintenanceScheduleType.time) ...[
                        const SizedBox(height: 16),
                        DropdownButtonFormField<MaintenanceTimeUnit>(
                          initialValue: _timeUnit,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: _isSaving ? null : () => _saveItem(details),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(_primaryActionLabel),
              ),
            ),
            if (_isEditing) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: _isSaving || details == null
                    ? null
                    : () => _deleteItem(details),
                child: const Text('Delete Maintenance Item'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String get _primaryActionLabel {
    if (_isEditing) {
      return 'Save Changes';
    }
    return _scheduleType == MaintenanceScheduleType.distance
        ? 'Create Item'
        : 'Create Time-Based Item';
  }

  void _hydrate(MaintenanceItemDetails details) {
    _didHydrate = true;
    _descriptionController.text = details.item.description;
    _intervalController.text = details.item.intervalValue.toString();
    _scheduleType = details.item.scheduleType;
    _timeUnit = details.item.timeUnit ?? MaintenanceTimeUnit.months;
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

  Future<void> _saveItem(MaintenanceItemDetails? existingDetails) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final controller = ref.read(maintenanceControllerProvider);
    final input = MaintenanceItemInput(
      description: _descriptionController.text,
      scheduleType: _scheduleType,
      intervalValue: int.parse(_intervalController.text),
      timeUnit: _scheduleType == MaintenanceScheduleType.time
          ? _timeUnit
          : null,
    );

    try {
      if (_isEditing) {
        await controller.updateItem(widget.itemId!, input);

        if (!mounted) {
          return;
        }

        final carId = existingDetails?.item.carProfileId ?? widget.carId!;
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/cars/$carId/maintenance/${widget.itemId}');
        }
        return;
      }

      await controller.createItem(widget.carId!, input);

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
        SnackBar(content: Text('Unable to save maintenance item.\n$error')),
      );
      setState(() => _isSaving = false);
    }
  }

  Future<void> _deleteItem(MaintenanceItemDetails details) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete maintenance item?'),
        content: const Text(
          'This will remove the item and its logged service history.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      await ref.read(maintenanceControllerProvider).deleteItem(details.item.id);
      if (!mounted) {
        return;
      }
      context.go('/cars/${details.item.carProfileId}/maintenance');
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to delete maintenance item.\n$error')),
      );
      setState(() => _isSaving = false);
    }
  }
}
