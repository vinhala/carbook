import 'package:carful/src/core/theme/app_theme.dart';
import 'package:carful/src/domain/repair_entry.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:carful/src/features/repairs/repair_controller.dart';
import 'package:carful/src/features/repairs/repair_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RepairOverviewScreen extends ConsumerStatefulWidget {
  const RepairOverviewScreen({super.key, required this.carId});

  final int? carId;

  @override
  ConsumerState<RepairOverviewScreen> createState() =>
      _RepairOverviewScreenState();
}

class _RepairOverviewScreenState extends ConsumerState<RepairOverviewScreen> {
  bool _showModifications = false;

  @override
  Widget build(BuildContext context) {
    if (widget.carId == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid repair section.')),
      );
    }

    final profileAsync = ref.watch(carProfileProvider(widget.carId!));
    final overviewAsync = ref.watch(
      repairOverviewProvider((
        carId: widget.carId!,
        modifications: _showModifications,
      )),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          profileAsync.asData?.value?.displayName ?? 'Repairs & Modifications',
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateSheet(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New entry'),
      ),
      body: SafeArea(
        child: overviewAsync.when(
          data: (overview) => ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
            children: [
              Text(
                'Repairs & Modifications',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Manage your vehicle's mechanical history and future upgrades.",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 20),
              SegmentedButton<bool>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment<bool>(value: false, label: Text('Repairs')),
                  ButtonSegment<bool>(
                    value: true,
                    label: Text('Modifications'),
                  ),
                ],
                selected: {_showModifications},
                onSelectionChanged: (selection) {
                  setState(() {
                    _showModifications = selection.first;
                  });
                },
              ),
              const SizedBox(height: 24),
              if (overview.planned.isNotEmpty) ...[
                const _SectionHeader(
                  title: 'Planned',
                  icon: Icons.calendar_month_rounded,
                ),
                const SizedBox(height: 12),
                ...overview.planned.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _PlannedRepairCard(
                      entry: entry,
                      onTap: () => context.push(
                        '/cars/${widget.carId}/repairs/${entry.id}',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (overview.past.isNotEmpty) ...[
                const _SectionHeader(
                  title: 'Past',
                  icon: Icons.history_rounded,
                ),
                const SizedBox(height: 12),
                ...overview.past.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _PastRepairCard(
                      entry: entry,
                      onTap: () => context.push(
                        '/cars/${widget.carId}/repairs/${entry.id}',
                      ),
                    ),
                  ),
                ),
              ],
              if (overview.planned.isEmpty && overview.past.isEmpty)
                _EmptyRepairState(
                  modifications: _showModifications,
                  onCreatePlanned: () =>
                      _openCreateEntry(context, planned: true),
                  onCreatePast: () => _openCreateEntry(context, planned: false),
                ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Unable to load repairs.\n$error'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCreateSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_month_rounded),
              title: Text('Plan ${repairSingularLabel(_showModifications)}'),
              subtitle: const Text('Track something you still need to do.'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _openCreateEntry(context, planned: true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history_rounded),
              title: Text(
                'Track past ${repairSingularLabel(_showModifications)}',
              ),
              subtitle: const Text(
                'Log something that has already been completed.',
              ),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _openCreateEntry(context, planned: false);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openCreateEntry(BuildContext context, {required bool planned}) {
    final status = planned ? 'planned' : 'completed';
    context.push(
      '/cars/${widget.carId}/repairs/new?status=$status&modification=$_showModifications',
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.tertiary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _PlannedRepairCard extends StatelessWidget {
  const _PlannedRepairCard({required this.entry, required this.onTap});

  final RepairEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final urgency = entry.urgency;

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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!entry.isModification && urgency != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: repairUrgencyBackground(urgency),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              formatRepairUrgencyLabel(urgency),
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: repairUrgencyColor(urgency),
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        Text(
                          entry.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.area.label,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      repairAreaIcon(entry.area),
                      color: AppTheme.tertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                formatRepairTimestamp(entry),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PastRepairCard extends StatelessWidget {
  const _PastRepairCard({required this.entry, required this.onTap});

  final RepairEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.title,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Completed',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.area.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatRepairTimestamp(entry),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyRepairState extends StatelessWidget {
  const _EmptyRepairState({
    required this.modifications,
    required this.onCreatePlanned,
    required this.onCreatePast,
  });

  final bool modifications;
  final VoidCallback onCreatePlanned;
  final VoidCallback onCreatePast;

  @override
  Widget build(BuildContext context) {
    final noun = repairCollectionLabel(modifications).toLowerCase();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(
                modifications
                    ? Icons.auto_fix_high_rounded
                    : Icons.build_rounded,
                size: 44,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No $noun yet',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              'Start by planning something upcoming or logging work that has already been finished.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onCreatePlanned,
              icon: const Icon(Icons.calendar_month_rounded),
              label: Text('Plan ${repairSingularLabel(modifications)}'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onCreatePast,
              icon: const Icon(Icons.history_rounded),
              label: Text('Track past ${repairSingularLabel(modifications)}'),
            ),
          ],
        ),
      ),
    );
  }
}
