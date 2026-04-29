import 'package:carful/src/domain/maintenance_item_details.dart';
import 'package:carful/src/domain/maintenance_item_input.dart';
import 'package:carful/src/domain/maintenance_schedule_type.dart';
import 'package:carful/src/domain/maintenance_time_unit.dart';
import 'package:carful/src/features/maintenance/maintenance_controller.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:carful/src/l10n/generated/app_localizations.dart';
import 'package:carful/src/l10n/l10n.dart';
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
      return Scaffold(
        body: Center(child: Text(context.l10n.invalidMaintenanceItem)),
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
          return Scaffold(
            body: Center(child: Text(context.l10n.maintenanceItemNotFound)),
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
            child: Text(
              context.l10n.unableToLoadMaintenanceItem(error.toString()),
            ),
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
          _isEditing
              ? context.l10n.editMaintenanceItem
              : context.l10n.newMaintenanceItem,
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
                    decoration: InputDecoration(
                      labelText: context.l10n.description,
                      hintText: context.l10n.oilChangeHint,
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
                        context.l10n.scheduleConfigurator,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<MaintenanceScheduleType>(
                          expandedInsets: EdgeInsets.zero,
                          segments: [
                            ButtonSegment(
                              value: MaintenanceScheduleType.distance,
                              label: Text(context.l10n.distance),
                              icon: const Icon(Icons.route_outlined),
                            ),
                            ButtonSegment(
                              value: MaintenanceScheduleType.time,
                              label: Text(context.l10n.time),
                              icon: const Icon(Icons.schedule_rounded),
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
                              ? context.l10n.distanceInterval
                              : context.l10n.timeInterval,
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
                                  child: Text(
                                    unit.localizedLabel(context.l10n),
                                  ),
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
                          decoration: InputDecoration(
                            labelText: context.l10n.timeUnit,
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
                child: Text(_primaryActionLabel(context.l10n)),
              ),
            ),
            if (_isEditing) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: _isSaving || details == null
                    ? null
                    : () => _deleteItem(details),
                child: Text(context.l10n.deleteMaintenanceItem),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _primaryActionLabel(AppLocalizations l10n) {
    if (_isEditing) {
      return l10n.saveChanges;
    }
    return _scheduleType == MaintenanceScheduleType.distance
        ? l10n.createItem
        : l10n.createTimeBasedItem;
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
      return context.l10n.fieldRequired;
    }
    return null;
  }

  String? _intervalValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.intervalRequired;
    }

    final interval = int.tryParse(value);
    if (interval == null || interval <= 0) {
      return context.l10n.enterValidInterval;
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
        SnackBar(
          content: Text(
            context.l10n.unableToSaveMaintenanceItem(error.toString()),
          ),
        ),
      );
      setState(() => _isSaving = false);
    }
  }

  Future<void> _deleteItem(MaintenanceItemDetails details) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteMaintenanceItemTitle),
        content: Text(context.l10n.deleteMaintenanceItemBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.delete),
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
        SnackBar(
          content: Text(
            context.l10n.unableToDeleteMaintenanceItem(error.toString()),
          ),
        ),
      );
      setState(() => _isSaving = false);
    }
  }
}
