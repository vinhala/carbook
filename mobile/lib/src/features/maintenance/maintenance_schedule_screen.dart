import 'package:carful/src/core/theme/app_theme.dart';
import 'package:carful/src/domain/maintenance_schedule_entry.dart';
import 'package:carful/src/features/maintenance/maintenance_controller.dart';
import 'package:carful/src/features/maintenance/maintenance_formatters.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MaintenanceScheduleScreen extends ConsumerWidget {
  const MaintenanceScheduleScreen({super.key, required this.carId});

  final int? carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (carId == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid maintenance schedule.')),
      );
    }

    final profileAsync = ref.watch(carProfileProvider(carId!));
    final scheduleAsync = ref.watch(maintenanceScheduleProvider(carId!));
    final manualsAsync = ref.watch(workshopManualsProvider(carId!));
    final hasManuals = manualsAsync.asData?.value.isNotEmpty ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(profileAsync.asData?.value?.displayName ?? 'Maintenance'),
        actions: [
          IconButton(
            key: const ValueKey('open-ai-schedule-generator-button'),
            tooltip: hasManuals
                ? 'Auto-generate schedule with AI'
                : 'Upload manuals to enable AI schedule generation',
            onPressed: hasManuals
                ? () => context.push('/cars/$carId/maintenance/suggestions')
                : null,
            icon: const Icon(Icons.auto_awesome_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/cars/$carId/maintenance/new'),
        icon: const Icon(Icons.add_task_outlined),
        label: const Text('New item'),
      ),
      body: SafeArea(
        child: scheduleAsync.when(
          data: (items) => _MaintenanceScheduleBody(
            items: items,
            mileageUnit: profileAsync.asData?.value?.mileageUnit ?? 'mi',
            onCreateItem: () => context.push('/cars/$carId/maintenance/new'),
            onOpenItem: (itemId) =>
                context.push('/cars/$carId/maintenance/$itemId'),
            onQuickLog: (itemId) =>
                context.push('/cars/$carId/maintenance/$itemId?log=true'),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Unable to load maintenance items.\n$error'),
            ),
          ),
        ),
      ),
    );
  }
}

class _MaintenanceScheduleBody extends StatelessWidget {
  const _MaintenanceScheduleBody({
    required this.items,
    required this.mileageUnit,
    required this.onCreateItem,
    required this.onOpenItem,
    required this.onQuickLog,
  });

  final List<MaintenanceScheduleEntry> items;
  final String mileageUnit;
  final VoidCallback onCreateItem;
  final ValueChanged<int> onOpenItem;
  final ValueChanged<int> onQuickLog;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
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
                      Icons.event_repeat_rounded,
                      size: 52,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No maintenance items yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Create your first recurring maintenance task to start tracking what is due next.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: onCreateItem,
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    label: const Text('Create maintenance item'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final overdueItems = items
        .where((item) => item.dueStatus.isOverdue)
        .toList();
    final upcomingItems = items
        .where((item) => !item.dueStatus.isOverdue)
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        if (overdueItems.isNotEmpty) ...[
          const _SectionHeader(
            title: 'Overdue',
            icon: Icons.warning_amber_rounded,
            color: AppTheme.secondary,
          ),
          const SizedBox(height: 12),
          ...overdueItems.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _MaintenanceCard(
                entry: entry,
                mileageUnit: mileageUnit,
                onTap: () => onOpenItem(entry.item.id),
                onQuickLog: () => onQuickLog(entry.item.id),
              ),
            ),
          ),
        ],
        if (upcomingItems.isNotEmpty) ...[
          if (overdueItems.isNotEmpty) const SizedBox(height: 8),
          const _SectionHeader(
            title: 'Upcoming',
            icon: Icons.schedule_rounded,
            color: AppTheme.primary,
          ),
          const SizedBox(height: 12),
          ...upcomingItems.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _MaintenanceCard(
                entry: entry,
                mileageUnit: mileageUnit,
                onTap: () => onOpenItem(entry.item.id),
                onQuickLog: () => onQuickLog(entry.item.id),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _MaintenanceCard extends StatelessWidget {
  const _MaintenanceCard({
    required this.entry,
    required this.mileageUnit,
    required this.onTap,
    required this.onQuickLog,
  });

  final MaintenanceScheduleEntry entry;
  final String mileageUnit;
  final VoidCallback onTap;
  final VoidCallback onQuickLog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      maintenanceIconForDescription(entry.item.description),
                      color: AppTheme.tertiary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.item.description,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatMaintenanceSchedule(
                            entry.item,
                            mileageUnit: mileageUnit,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Next target: ${formatMaintenanceNextTarget(entry.dueStatus, mileageUnit: mileageUnit)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton.tonalIcon(
                        onPressed: onQuickLog,
                        icon: const Icon(Icons.edit_document),
                        label: const Text('Log'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
