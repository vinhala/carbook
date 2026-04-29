import 'dart:io';

import 'package:carful/src/core/theme/app_theme.dart';
import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/workshop_manual.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:carful/src/features/repairs/repair_controller.dart';
import 'package:carful/src/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class CarProfileScreen extends ConsumerWidget {
  const CarProfileScreen({super.key, required this.carId});

  final int? carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (carId == null) {
      return Scaffold(
        body: Center(child: Text(context.l10n.invalidCarProfile)),
      );
    }

    final profileAsync = ref.watch(carProfileProvider(carId!));
    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return Scaffold(
            body: Center(child: Text(context.l10n.carProfileNotFound)),
          );
        }
        return _CarProfileView(profile: profile);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(context.l10n.unableToLoadProfile(error.toString())),
        ),
      ),
    );
  }
}

class _CarProfileView extends ConsumerStatefulWidget {
  const _CarProfileView({required this.profile});

  final CarProfile profile;

  @override
  ConsumerState<_CarProfileView> createState() => _CarProfileViewState();
}

class _CarProfileViewState extends ConsumerState<_CarProfileView> {
  bool _isAddingManual = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final profile = widget.profile;
    final registration = DateFormat.yMMMM(
      localeName,
    ).format(profile.firstRegistrationMonth);
    final mileage = NumberFormat.decimalPattern(
      localeName,
    ).format(profile.currentMileage);
    final lastUpdated = DateFormat.yMMMd(
      localeName,
    ).add_Hm().format(profile.lastMileageUpdatedAt);
    final imageProvider =
        profile.photoPath != null && File(profile.photoPath!).existsSync()
        ? FileImage(File(profile.photoPath!))
        : null;
    final plannedRepairsAsync = ref.watch(
      plannedRepairCountProvider(profile.id),
    );
    final manualsAsync = ref.watch(workshopManualsProvider(profile.id));
    final hasManuals = manualsAsync.asData?.value.isNotEmpty ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(profile.displayName),
        actions: [
          IconButton(
            tooltip: l10n.editProfile,
            onPressed: () => context.push('/cars/${profile.id}/edit'),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                image: imageProvider != null
                    ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                    : null,
                gradient: imageProvider == null
                    ? const LinearGradient(
                        colors: [AppTheme.primaryContainer, AppTheme.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
              child: imageProvider == null
                  ? const Center(
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        size: 88,
                        color: AppTheme.tertiary,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
            Text(
              profile.displayName,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${profile.engine} • ${l10n.registeredDate(registration)}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            _DetailCard(
              title: l10n.mileage,
              trailing: OutlinedButton.icon(
                onPressed: () => _showMileageDialog(context, ref, profile),
                icon: const Icon(Icons.speed_rounded),
                label: Text(l10n.updateMileage),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$mileage ${profile.mileageUnit}',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.lastUpdatedOn(lastUpdated),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: l10n.vehicleDetails,
              child: Column(
                children: [
                  _InfoRow(label: l10n.make, value: profile.make),
                  _InfoRow(label: l10n.model, value: profile.model),
                  _InfoRow(label: l10n.engine, value: profile.engine),
                  _InfoRow(label: l10n.vin, value: profile.vin),
                  _InfoRow(
                    label: l10n.firstRegistration,
                    value: registration,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: l10n.mileageReminder,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: profile.reminderFrequency.showsWarning
                          ? AppTheme.secondary
                          : AppTheme.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      profile.reminderFrequency.localizedLabel(l10n),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.reminderFrequency.showsWarning
                        ? l10n.mileageReminderWarningBody
                        : l10n.mileageReminderNudgeBody,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: l10n.maintenanceSchedule,
              trailing: FilledButton.tonalIcon(
                onPressed: () =>
                    context.push('/cars/${profile.id}/maintenance'),
                icon: const Icon(Icons.event_repeat_rounded),
                label: Text(l10n.open),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.maintenanceScheduleCardBody,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.build_circle_outlined,
                        color: AppTheme.tertiary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.maintenanceScheduleCardHint,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: l10n.repairsModifications,
              trailing: FilledButton.tonalIcon(
                key: const ValueKey('open-repairs-button'),
                onPressed: () => context.push('/cars/${profile.id}/repairs'),
                icon: const Icon(Icons.build_rounded),
                label: Text(l10n.open),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.repairsModificationsBody,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: plannedRepairsAsync.when(
                      data: (count) => Text(
                        key: const ValueKey('planned-repairs-count'),
                        l10n.plannedRepairCount(count),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      loading: () => Text(l10n.loadingPlannedRepairs),
                      error: (error, stackTrace) =>
                          Text(l10n.unableToLoadPlannedRepairs),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: l10n.workshopManuals,
              trailing: FilledButton.tonalIcon(
                key: const ValueKey('add-manual-button'),
                onPressed: _isAddingManual ? null : () => _addManuals(context),
                icon: _isAddingManual
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.upload_file_rounded),
                label: Text(_isAddingManual ? l10n.adding : l10n.addManual),
              ),
              child: manualsAsync.when(
                data: (manuals) => _WorkshopManualList(
                  manuals: manuals,
                  onOpenManual: (manual) => _openManual(context, manual),
                  onDeleteManual: (manual) =>
                      _confirmDeleteManual(context, ref, profile, manual),
                ),
                loading: () => Text(l10n.loadingManuals),
                error: (error, stackTrace) => Text(
                  l10n.unableToLoadManuals(error.toString()),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.error,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: l10n.aiAssistant,
              trailing: FilledButton.tonalIcon(
                key: const ValueKey('open-ai-assistant-button'),
                onPressed: hasManuals
                    ? () => context.push('/cars/${profile.id}/assistant')
                    : null,
                icon: const Icon(Icons.smart_toy_outlined),
                label: Text(l10n.open),
              ),
              child: Text(
                hasManuals
                    ? l10n.aiAssistantReadyBody
                    : l10n.aiAssistantNeedsManual,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMileageDialog(
    BuildContext context,
    WidgetRef ref,
    CarProfile profile,
  ) async {
    final controller = TextEditingController(
      text: profile.currentMileage.toString(),
    );
    final formKey = GlobalKey<FormState>();
    final actions = ref.read(carProfileControllerProvider);

    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.updateMileage),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              labelText: context.l10n.mileage,
              suffixText: profile.mileageUnit,
            ),
            validator: (value) {
              final mileage = int.tryParse(value ?? '');
              if (mileage == null || mileage < 0) {
                return context.l10n.enterValidMileage;
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(dialogContext).pop(true);
              }
            },
            child: Text(context.l10n.save),
          ),
        ],
      ),
    );

    if (submitted != true) {
      controller.dispose();
      return;
    }

    try {
      await actions.updateMileage(profile.id, int.parse(controller.text));
    } catch (error) {
      if (!context.mounted) {
        controller.dispose();
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.unableToUpdateMileage(error.toString())),
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  Future<void> _addManuals(BuildContext context) async {
    setState(() {
      _isAddingManual = true;
    });
    try {
      await ref
          .read(carProfileControllerProvider)
          .addWorkshopManuals(widget.profile);
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.unableToAddWorkshopManuals(error.toString()),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAddingManual = false;
        });
      }
    }
  }

  Future<void> _openManual(BuildContext context, WorkshopManual manual) async {
    final result = await OpenFilex.open(manual.localPath);
    if (result.type != ResultType.done && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.unableToOpenFile(manual.originalName)),
        ),
      );
    }
  }

  Future<void> _confirmDeleteManual(
    BuildContext context,
    WidgetRef ref,
    CarProfile profile,
    WorkshopManual manual,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.removeWorkshopManualTitle),
        content: Text(
          context.l10n.removeWorkshopManualBody(manual.originalName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(context.l10n.remove),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    try {
      await ref
          .read(carProfileControllerProvider)
          .removeWorkshopManual(profile, manual);
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.unableToRemoveManual(error.toString())),
        ),
      );
    }
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.title, required this.child, this.trailing});

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // ignore: use_null_aware_elements
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 132,
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        if (!isLast) ...[
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class _WorkshopManualList extends StatelessWidget {
  const _WorkshopManualList({
    required this.manuals,
    required this.onOpenManual,
    required this.onDeleteManual,
  });

  final List<WorkshopManual> manuals;
  final ValueChanged<WorkshopManual> onOpenManual;
  final ValueChanged<WorkshopManual> onDeleteManual;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (manuals.isEmpty) {
      return Text(
        context.l10n.addPdfManuals,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.textSecondary,
        ),
      );
    }

    return Column(
      children: manuals
          .map(
            (manual) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => onOpenManual(manual),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceLow,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.surfaceVariant),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDAD6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.picture_as_pdf_outlined,
                          color: AppTheme.error,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              manual.originalName,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(manual.byteSize / 1024).toStringAsFixed(1)} KB',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Delete manual',
                        onPressed: () => onDeleteManual(manual),
                        icon: const Icon(Icons.delete_outline_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
