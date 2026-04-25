import 'dart:io';

import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/domain/repair_attachment.dart';
import 'package:carbook/src/domain/repair_entry_details.dart';
import 'package:carbook/src/features/repairs/repair_controller.dart';
import 'package:carbook/src/features/repairs/repair_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';

class RepairEntryScreen extends ConsumerWidget {
  const RepairEntryScreen({super.key, required this.entryId});

  final int? entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (entryId == null) {
      return const Scaffold(body: Center(child: Text('Invalid repair entry.')));
    }

    final detailsAsync = ref.watch(repairEntryProvider(entryId!));
    return detailsAsync.when(
      data: (details) {
        if (details == null) {
          return const Scaffold(
            body: Center(child: Text('This repair entry could not be found.')),
          );
        }

        final imageFiles = imageAttachments(details.attachments);
        final documents = fileAttachments(details.attachments);

        return Scaffold(
          appBar: AppBar(
            title: Text(details.entry.title),
            actions: [
              IconButton(
                tooltip: 'Edit entry',
                onPressed: () => context.push(
                  '/cars/${details.entry.carProfileId}/repairs/${details.entry.id}/edit',
                ),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                _RepairHeader(details: details),
                const SizedBox(height: 16),
                if ((details.entry.description?.isNotEmpty ?? false))
                  _DescriptionCard(details: details),
                if ((details.entry.description?.isNotEmpty ?? false))
                  const SizedBox(height: 16),
                if (details.parts.isNotEmpty)
                  _PartsCard(
                    details: details,
                    onOpenLink: (link) => _openLink(context, link),
                  ),
                if (details.parts.isNotEmpty) const SizedBox(height: 16),
                if (imageFiles.isNotEmpty)
                  _GalleryCard(
                    attachments: imageFiles,
                    onTap: (attachment) => _openAttachment(context, attachment),
                  ),
                if (imageFiles.isNotEmpty) const SizedBox(height: 16),
                if (documents.isNotEmpty)
                  _DocumentsCard(
                    attachments: documents,
                    onTap: (attachment) => _openAttachment(context, attachment),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: details.entry.isPlanned
                ? FilledButton.icon(
                    onPressed: () => _confirmCompletion(context, ref, details),
                    icon: const Icon(Icons.check_circle_outline_rounded),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Complete Repair'),
                    ),
                  )
                : OutlinedButton.icon(
                    onPressed: () => _confirmReopen(context, ref, details),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Reopen Repair'),
                    ),
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
            child: Text('Unable to load repair details.\n$error'),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmCompletion(
    BuildContext context,
    WidgetRef ref,
    RepairEntryDetails details,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as completed?'),
        content: const Text(
          'Carbook will move this planned repair into your past repairs using the current date.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    await ref.read(repairControllerProvider).markCompleted(details.entry.id);
  }

  Future<void> _confirmReopen(
    BuildContext context,
    WidgetRef ref,
    RepairEntryDetails details,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reopen repair?'),
        content: const Text(
          'Carbook will move this completed repair back into your planned list.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Reopen'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    await ref.read(repairControllerProvider).reopen(details.entry.id);
  }

  Future<void> _openLink(BuildContext context, String link) async {
    final uri = Uri.tryParse(link);
    if (uri == null ||
        !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open the link.')),
        );
      }
    }
  }

  Future<void> _openAttachment(
    BuildContext context,
    RepairAttachment attachment,
  ) async {
    final result = await OpenFilex.open(attachment.storedPath);
    if (result.type != ResultType.done && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to open ${attachment.originalName}.')),
      );
    }
  }
}

class _RepairHeader extends StatelessWidget {
  const _RepairHeader({required this.details});

  final RepairEntryDetails details;

  @override
  Widget build(BuildContext context) {
    final urgency = details.entry.urgency;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Badge(label: details.entry.area.label),
                _Badge(label: repairTypeBadgeLabel(details.entry)),
                if (urgency != null && !details.entry.isModification)
                  _Badge(
                    label: formatRepairUrgencyLabel(urgency),
                    background: repairUrgencyBackground(urgency),
                    foreground: repairUrgencyColor(urgency),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              details.entry.title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  details.entry.isCompleted
                      ? Icons.check_circle_outline_rounded
                      : Icons.schedule_rounded,
                  color: details.entry.isCompleted
                      ? AppTheme.primary
                      : AppTheme.tertiary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    formatRepairTimestamp(details.entry),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard({required this.details});

  final RepairEntryDetails details;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            Text(
              details.entry.description!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PartsCard extends StatelessWidget {
  const _PartsCard({required this.details, required this.onOpenLink});

  final RepairEntryDetails details;
  final ValueChanged<String> onOpenLink;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Parts',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            ...details.parts.map(
              (part) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceLow,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.settings_suggest_rounded,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            part.title,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          if (part.link != null) ...[
                            const SizedBox(height: 6),
                            InkWell(
                              onTap: () => onOpenLink(part.link!),
                              child: Text(
                                'View part',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ],
                        ],
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
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.attachments, required this.onTap});

  final List<RepairAttachment> attachments;
  final ValueChanged<RepairAttachment> onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gallery',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: attachments
                  .map(
                    (attachment) => InkWell(
                      onTap: () => onTap(attachment),
                      borderRadius: BorderRadius.circular(18),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SizedBox(
                          width: 140,
                          height: 96,
                          child: Image.file(
                            File(attachment.storedPath),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: AppTheme.surfaceLow,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.broken_image_outlined,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentsCard extends StatelessWidget {
  const _DocumentsCard({required this.attachments, required this.onTap});

  final List<RepairAttachment> attachments;
  final ValueChanged<RepairAttachment> onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Files',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            ...attachments.map(
              (attachment) => ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => onTap(attachment),
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceLow,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.insert_drive_file_outlined),
                ),
                title: Text(attachment.originalName),
                subtitle: Text(
                  attachment.fileExtension?.toUpperCase() ?? 'FILE',
                ),
                trailing: const Icon(Icons.open_in_new_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    this.background = AppTheme.surfaceLow,
    this.foreground = AppTheme.textSecondary,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
