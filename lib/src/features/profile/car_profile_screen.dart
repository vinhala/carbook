import 'dart:io';

import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/domain/car_profile.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CarProfileScreen extends ConsumerWidget {
  const CarProfileScreen({super.key, required this.carId});

  final int? carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (carId == null) {
      return const Scaffold(body: Center(child: Text('Invalid car profile.')));
    }

    final profileAsync = ref.watch(carProfileProvider(carId!));
    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return const Scaffold(
            body: Center(child: Text('This car profile could not be found.')),
          );
        }
        return _CarProfileView(profile: profile);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('Unable to load the profile.\n$error')),
      ),
    );
  }
}

class _CarProfileView extends ConsumerWidget {
  const _CarProfileView({required this.profile});

  final CarProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final registration = DateFormat.yMMMM().format(
      profile.firstRegistrationMonth,
    );
    final mileage = NumberFormat.decimalPattern().format(
      profile.currentMileage,
    );
    final lastUpdated = DateFormat.yMMMd().add_Hm().format(
      profile.lastMileageUpdatedAt,
    );
    final imageProvider =
        profile.photoPath != null && File(profile.photoPath!).existsSync()
        ? FileImage(File(profile.photoPath!))
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(profile.displayName),
        actions: [
          IconButton(
            tooltip: 'Edit profile',
            onPressed: () => context.go('/cars/${profile.id}/edit'),
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
              '${profile.engine} • Registered $registration',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            _DetailCard(
              title: 'Mileage',
              trailing: OutlinedButton.icon(
                onPressed: () => _showMileageDialog(context, ref, profile),
                icon: const Icon(Icons.speed_rounded),
                label: const Text('Update mileage'),
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
                    'Last updated on $lastUpdated',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: 'Vehicle details',
              child: Column(
                children: [
                  _InfoRow(label: 'Make', value: profile.make),
                  _InfoRow(label: 'Model', value: profile.model),
                  _InfoRow(label: 'Engine', value: profile.engine),
                  _InfoRow(label: 'VIN', value: profile.vin),
                  _InfoRow(
                    label: 'First registration',
                    value: registration,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: 'Mileage reminder',
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
                      profile.reminderFrequency.label,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile.reminderFrequency.showsWarning
                        ? 'This cadence can make it easier to miss critical maintenance intervals.'
                        : 'Carbook will keep nudging you to keep mileage fresh for future maintenance tracking.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _DetailCard(
              title: 'Maintenance schedule',
              trailing: FilledButton.tonalIcon(
                onPressed: () =>
                    context.push('/cars/${profile.id}/maintenance'),
                icon: const Icon(Icons.event_repeat_rounded),
                label: const Text('Open'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Track recurring maintenance, see what is overdue, and log completed service from one place.',
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
                          'Create mileage- or time-based items for this vehicle.',
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
              title: 'Workshop manuals',
              child: Text(
                'Workshop manual upload and display are intentionally deferred to Epic 5.',
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
        title: const Text('Update mileage'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
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
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(dialogContext).pop(true);
              }
            },
            child: const Text('Save'),
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
        SnackBar(content: Text('Unable to update mileage.\n$error')),
      );
    } finally {
      controller.dispose();
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
