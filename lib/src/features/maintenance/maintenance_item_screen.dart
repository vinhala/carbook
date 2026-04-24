import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/domain/maintenance_item_details.dart';
import 'package:carbook/src/domain/maintenance_log_input.dart';
import 'package:carbook/src/features/maintenance/maintenance_controller.dart';
import 'package:carbook/src/features/maintenance/maintenance_formatters.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MaintenanceItemScreen extends ConsumerStatefulWidget {
  const MaintenanceItemScreen({
    super.key,
    required this.itemId,
    this.openLogComposer = false,
  });

  final int? itemId;
  final bool openLogComposer;

  @override
  ConsumerState<MaintenanceItemScreen> createState() =>
      _MaintenanceItemScreenState();
}

class _MaintenanceItemScreenState extends ConsumerState<MaintenanceItemScreen> {
  bool _hasOpenedComposer = false;

  @override
  Widget build(BuildContext context) {
    if (widget.itemId == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid maintenance item.')),
      );
    }

    final detailsAsync = ref.watch(maintenanceItemProvider(widget.itemId!));

    return detailsAsync.when(
      data: (details) {
        if (details == null) {
          return const Scaffold(
            body: Center(
              child: Text('This maintenance item could not be found.'),
            ),
          );
        }

        if (widget.openLogComposer && !_hasOpenedComposer) {
          _hasOpenedComposer = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _openLogComposer(details);
            }
          });
        }

        final profileAsync = ref.watch(
          carProfileProvider(details.item.carProfileId),
        );
        final currentMileage = profileAsync.asData?.value?.currentMileage;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: 'Back to maintenance',
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/cars/${details.item.carProfileId}/maintenance');
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(details.item.description),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openLogComposer(details),
            icon: const Icon(Icons.edit_document),
            label: const Text('Log work'),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceLow,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                maintenanceIconForDescription(
                                  details.item.description,
                                ),
                                color: AppTheme.tertiary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    details.item.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    formatMaintenanceSchedule(details.item),
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: AppTheme.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _StatusBanner(details: details),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Next required work',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 16),
                        _SummaryRow(
                          label: 'Next target',
                          value: formatMaintenanceNextTarget(details.dueStatus),
                        ),
                        _SummaryRow(
                          label: 'Status',
                          value: formatMaintenanceDueLabel(details.dueStatus),
                        ),
                        _SummaryRow(
                          label: 'Last service',
                          value: details.dueStatus.lastPerformedAt == null
                              ? 'No work logged yet'
                              : DateFormat.yMMMd().format(
                                  details.dueStatus.lastPerformedAt!,
                                ),
                          isLast: currentMileage == null,
                        ),
                        if (currentMileage != null)
                          _SummaryRow(
                            label: 'Current odometer',
                            value: formatPerformedMileage(currentMileage),
                            isLast: true,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service history',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 16),
                        if (details.logs.isEmpty)
                          Text(
                            'No performed work has been logged for this item yet.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppTheme.textSecondary),
                          )
                        else
                          ...details.logs.map(
                            (log) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _HistoryCard(
                                performedAt: log.performedAt,
                                mileage: log.mileage,
                                note: log.note,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Unable to load maintenance details.\n$error'),
          ),
        ),
      ),
    );
  }

  Future<void> _openLogComposer(MaintenanceItemDetails details) async {
    final profile = ref
        .read(carProfileProvider(details.item.carProfileId))
        .asData
        ?.value;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _LogPerformedWorkSheet(
        itemId: details.item.id,
        initialMileage:
            profile?.currentMileage ?? details.dueStatus.lastPerformedMileage,
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.details});

  final MaintenanceItemDetails details;

  @override
  Widget build(BuildContext context) {
    final isOverdue = details.dueStatus.isOverdue;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isOverdue ? const Color(0xFFFFF2D1) : AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            isOverdue
                ? Icons.warning_amber_rounded
                : Icons.check_circle_outline,
            color: isOverdue ? AppTheme.tertiary : AppTheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              formatMaintenanceDueLabel(details.dueStatus),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.performedAt,
    required this.mileage,
    required this.note,
  });

  final DateTime performedAt;
  final int mileage;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final noteText = note;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat.yMMMd().format(performedAt),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
              Text(
                formatPerformedMileage(mileage),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
          if (noteText != null && noteText.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              noteText,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}

class _LogPerformedWorkSheet extends ConsumerStatefulWidget {
  const _LogPerformedWorkSheet({required this.itemId, this.initialMileage});

  final int itemId;
  final int? initialMileage;

  @override
  ConsumerState<_LogPerformedWorkSheet> createState() =>
      _LogPerformedWorkSheetState();
}

class _LogPerformedWorkSheetState
    extends ConsumerState<_LogPerformedWorkSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _mileageController;
  late final TextEditingController _noteController;
  late DateTime _performedAt;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _performedAt = DateTime.now();
    _mileageController = TextEditingController(
      text: widget.initialMileage?.toString() ?? '',
    );
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _mileageController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, insets),
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Log Performed Work',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _isSaving ? null : _pickDate,
                  borderRadius: BorderRadius.circular(18),
                  child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Date'),
                    child: Row(
                      children: [
                        const Icon(Icons.event_outlined),
                        const SizedBox(width: 12),
                        Text(DateFormat.yMMMd().format(_performedAt)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mileageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Mileage',
                    suffixText: 'mi',
                  ),
                  validator: (value) {
                    final mileage = int.tryParse(value ?? '');
                    if (mileage == null || mileage < 0) {
                      return 'Enter a valid mileage.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noteController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText:
                        'Optional notes about parts, fluids, or observations',
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: const Icon(Icons.add_task),
                  label: const Text('Log Performed Work'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _performedAt,
      firstDate: DateTime(1990),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _performedAt = DateTime(
        selected.year,
        selected.month,
        selected.day,
        _performedAt.hour,
        _performedAt.minute,
      );
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);

    try {
      await ref
          .read(maintenanceControllerProvider)
          .addPerformedWork(
            widget.itemId,
            MaintenanceLogInput(
              performedAt: _performedAt,
              mileage: int.parse(_mileageController.text),
              note: _noteController.text,
            ),
          );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to log performed work.\n$error')),
      );
      setState(() => _isSaving = false);
    }
  }
}
