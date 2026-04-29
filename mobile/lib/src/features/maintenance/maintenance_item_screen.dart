import 'package:carful/src/core/theme/app_theme.dart';
import 'package:carful/src/domain/maintenance_item_details.dart';
import 'package:carful/src/domain/maintenance_log_input.dart';
import 'package:carful/src/features/maintenance/maintenance_controller.dart';
import 'package:carful/src/features/maintenance/maintenance_formatters.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:carful/src/l10n/l10n.dart';
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
      return Scaffold(
        body: Center(child: Text(context.l10n.invalidMaintenanceItem)),
      );
    }

    final detailsAsync = ref.watch(maintenanceItemProvider(widget.itemId!));

    return detailsAsync.when(
      data: (details) {
        if (details == null) {
          return Scaffold(
            body: Center(child: Text(context.l10n.maintenanceItemNotFound)),
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
        final mileageUnit = profileAsync.asData?.value?.mileageUnit ?? 'mi';

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: context.l10n.backToMaintenance,
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
            actions: [
              IconButton(
                tooltip: context.l10n.editMaintenanceItem,
                onPressed: () => context.push(
                  '/cars/${details.item.carProfileId}/maintenance/${details.item.id}/edit',
                ),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openLogComposer(details),
            icon: const Icon(Icons.edit_document),
            label: Text(context.l10n.logWork),
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
                                    formatMaintenanceSchedule(
                                      details.item,
                                      l10n: context.l10n,
                                      localeName: Localizations.localeOf(
                                        context,
                                      ).toLanguageTag(),
                                      mileageUnit: mileageUnit,
                                    ),
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
                        _StatusBanner(
                          details: details,
                          mileageUnit: mileageUnit,
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
                          context.l10n.nextRequiredWork,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 16),
                        _SummaryRow(
                          label: context.l10n.nextTargetLabel,
                          value: formatMaintenanceNextTarget(
                            details.dueStatus,
                            l10n: context.l10n,
                            localeName: Localizations.localeOf(
                              context,
                            ).toLanguageTag(),
                            mileageUnit: mileageUnit,
                          ),
                        ),
                        _SummaryRow(
                          label: context.l10n.status,
                          value: formatMaintenanceDueLabel(
                            details.dueStatus,
                            l10n: context.l10n,
                            localeName: Localizations.localeOf(
                              context,
                            ).toLanguageTag(),
                            mileageUnit: mileageUnit,
                          ),
                        ),
                        _SummaryRow(
                          label: context.l10n.lastService,
                          value: details.dueStatus.lastPerformedAt == null
                              ? context.l10n.noWorkLoggedYet
                              : DateFormat.yMMMd(
                                  Localizations.localeOf(
                                    context,
                                  ).toLanguageTag(),
                                ).format(details.dueStatus.lastPerformedAt!),
                          isLast: currentMileage == null,
                        ),
                        if (currentMileage != null)
                          _SummaryRow(
                            label: context.l10n.currentOdometer,
                            value: formatPerformedMileage(
                              currentMileage,
                              l10n: context.l10n,
                              localeName: Localizations.localeOf(
                                context,
                              ).toLanguageTag(),
                              mileageUnit: mileageUnit,
                            ),
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
                          context.l10n.serviceHistory,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 16),
                        if (details.logs.isEmpty)
                          Text(
                            context.l10n.noPerformedWork,
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
                                mileageUnit: mileageUnit,
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
            child: Text(
              context.l10n.unableToLoadMaintenanceDetails(error.toString()),
            ),
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
        mileageUnit: profile?.mileageUnit ?? 'mi',
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.details, required this.mileageUnit});

  final MaintenanceItemDetails details;
  final String mileageUnit;

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
              formatMaintenanceDueLabel(
                details.dueStatus,
                l10n: context.l10n,
                localeName: Localizations.localeOf(context).toLanguageTag(),
                mileageUnit: mileageUnit,
              ),
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
    required this.mileageUnit,
  });

  final DateTime performedAt;
  final int mileage;
  final String? note;
  final String mileageUnit;

  @override
  Widget build(BuildContext context) {
    final noteText = note;
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();

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
                  DateFormat.yMMMd(localeName).format(performedAt),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
              Text(
                formatPerformedMileage(
                  mileage,
                  l10n: l10n,
                  localeName: localeName,
                  mileageUnit: mileageUnit,
                ),
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
  const _LogPerformedWorkSheet({
    required this.itemId,
    this.initialMileage,
    this.mileageUnit = 'mi',
  });

  final int itemId;
  final int? initialMileage;
  final String mileageUnit;

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
                  context.l10n.logPerformedWork,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: _isSaving ? null : _pickDate,
                  borderRadius: BorderRadius.circular(18),
                  child: InputDecorator(
                    decoration: InputDecoration(labelText: context.l10n.date),
                    child: Row(
                      children: [
                        const Icon(Icons.event_outlined),
                        const SizedBox(width: 12),
                        Text(
                          DateFormat.yMMMd(
                            Localizations.localeOf(context).toLanguageTag(),
                          ).format(_performedAt),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mileageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: context.l10n.mileage,
                    suffixText: widget.mileageUnit,
                  ),
                  validator: (value) {
                    final mileage = int.tryParse(value ?? '');
                    if (mileage == null || mileage < 0) {
                      return context.l10n.enterValidMileage;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noteController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: context.l10n.notes,
                    hintText: context.l10n.notesHint,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _isSaving ? null : _save,
                  icon: const Icon(Icons.add_task),
                  label: Text(context.l10n.logPerformedWork),
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
        SnackBar(
          content: Text(
            context.l10n.unableToLogPerformedWork(error.toString()),
          ),
        ),
      );
      setState(() => _isSaving = false);
    }
  }
}
