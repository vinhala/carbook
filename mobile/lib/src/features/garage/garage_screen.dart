import 'dart:io';

import 'package:carful/src/core/theme/app_theme.dart';
import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:carful/src/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class GarageScreen extends ConsumerWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilesAsync = ref.watch(garageProfilesProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/cars/new'),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.addCar),
      ),
      body: SafeArea(
        child: profilesAsync.when(
          data: (profiles) {
            if (profiles.isEmpty) {
              return _GarageEmptyState(
                onCreateProfile: () => context.push('/cars/new'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              itemCount: profiles.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return _GarageCard(
                  profile: profile,
                  onTap: () => context.push('/cars/${profile.id}'),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.unableToLoadGarage(error.toString())),
            ),
          ),
        ),
      ),
    );
  }
}

class _GarageEmptyState extends StatelessWidget {
  const _GarageEmptyState({required this.onCreateProfile});

  final VoidCallback onCreateProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.garage_rounded,
                    size: 52,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.garageEmptyTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  context.l10n.garageEmptyBody,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: onCreateProfile,
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  label: Text(context.l10n.createFirstProfile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GarageCard extends StatelessWidget {
  const _GarageCard({required this.profile, required this.onTap});

  final CarProfile profile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final registration = DateFormat.yMMM(
      localeName,
    ).format(profile.firstRegistrationMonth);
    final mileage = NumberFormat.decimalPattern(
      localeName,
    ).format(profile.currentMileage);
    final imageProvider =
        profile.photoPath != null && File(profile.photoPath!).existsSync()
        ? FileImage(File(profile.photoPath!))
        : null;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
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
                        size: 76,
                        color: AppTheme.tertiary,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          profile.displayName,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
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
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${profile.engine} • $registration',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _MetaItem(
                        icon: Icons.speed_rounded,
                        label: '$mileage ${profile.mileageUnit}',
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _MetaItem(
                          icon: Icons.confirmation_number_outlined,
                          label: profile.vin,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppTheme.textSecondary),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
          ),
        ),
      ],
    );
  }
}
