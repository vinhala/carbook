import 'dart:io';

import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/domain/repair_area.dart';
import 'package:carbook/src/domain/repair_attachment.dart';
import 'package:carbook/src/domain/repair_attachment_kind.dart';
import 'package:carbook/src/domain/repair_entry_details.dart';
import 'package:carbook/src/domain/repair_entry_input.dart';
import 'package:carbook/src/domain/repair_part.dart';
import 'package:carbook/src/domain/repair_part_input.dart';
import 'package:carbook/src/domain/repair_status.dart';
import 'package:carbook/src/domain/repair_urgency.dart';
import 'package:carbook/src/features/repairs/repair_controller.dart';
import 'package:carbook/src/features/repairs/repair_formatters.dart';
import 'package:carbook/src/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RepairEntryEditorScreen extends ConsumerStatefulWidget {
  const RepairEntryEditorScreen({
    super.key,
    this.carId,
    this.entryId,
    required this.initialStatus,
    required this.initialModification,
  });

  final int? carId;
  final int? entryId;
  final RepairStatus initialStatus;
  final bool initialModification;

  @override
  ConsumerState<RepairEntryEditorScreen> createState() =>
      _RepairEntryEditorScreenState();
}

class _RepairEntryEditorScreenState
    extends ConsumerState<RepairEntryEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  RepairArea _area = RepairArea.engine;
  RepairUrgency _urgency = RepairUrgency.medium;
  late RepairStatus _status;
  late bool _isModification;
  DateTime? _completedAt;
  bool _isSaving = false;
  bool _didHydrate = false;
  final List<_PartDraft> _parts = [];
  final List<_AttachmentDraft> _attachments = [];

  bool get _isEditing => widget.entryId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _status = widget.initialStatus;
    _isModification = widget.initialModification;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEditing && widget.carId == null) {
      return const Scaffold(body: Center(child: Text('Invalid repair entry.')));
    }

    final detailsAsync = _isEditing
        ? ref.watch(repairEntryProvider(widget.entryId!))
        : const AsyncValue<RepairEntryDetails?>.data(null);

    return detailsAsync.when(
      data: (details) {
        if (_isEditing && details == null) {
          return const Scaffold(
            body: Center(child: Text('This repair entry could not be found.')),
          );
        }

        if (details != null && !_didHydrate) {
          _hydrate(details);
        }

        return Scaffold(
          appBar: AppBar(title: Text(_isEditing ? 'Edit Entry' : 'New Entry')),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            key: const ValueKey('repair-title-field'),
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: _requiredValidator,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            key: const ValueKey('repair-description-field'),
                            controller: _descriptionController,
                            minLines: 3,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
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
                          DropdownButtonFormField<RepairArea>(
                            initialValue: _area,
                            decoration: const InputDecoration(
                              labelText: 'Area of vehicle',
                            ),
                            items: RepairArea.values
                                .map(
                                  (area) => DropdownMenuItem(
                                    value: area,
                                    child: Text(area.label),
                                  ),
                                )
                                .toList(),
                            onChanged: _isSaving
                                ? null
                                : (value) {
                                    if (value == null) {
                                      return;
                                    }
                                    setState(() => _area = value);
                                  },
                          ),
                          const SizedBox(height: 20),
                          SwitchListTile.adaptive(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Mark as modification'),
                            subtitle: const Text(
                              'Logs this as an upgrade rather than a repair.',
                            ),
                            value: _isModification,
                            onChanged: _isSaving
                                ? null
                                : (value) {
                                    setState(() => _isModification = value);
                                  },
                          ),
                          if (_status.isPlanned && !_isModification) ...[
                            const SizedBox(height: 20),
                            Text(
                              'Urgency',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: SegmentedButton<RepairUrgency>(
                                expandedInsets: EdgeInsets.zero,
                                showSelectedIcon: false,
                                segments: const [
                                  ButtonSegment(
                                    value: RepairUrgency.low,
                                    label: Text('Low'),
                                  ),
                                  ButtonSegment(
                                    value: RepairUrgency.medium,
                                    label: Text('Medium'),
                                  ),
                                  ButtonSegment(
                                    value: RepairUrgency.high,
                                    label: Text('High'),
                                  ),
                                ],
                                selected: {_urgency},
                                onSelectionChanged: _isSaving
                                    ? null
                                    : (selection) {
                                        setState(
                                          () => _urgency = selection.first,
                                        );
                                      },
                              ),
                            ),
                          ],
                          if (_status.isCompleted) ...[
                            const SizedBox(height: 20),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Completion date'),
                              subtitle: Text(
                                _completedAt == null
                                    ? 'Choose a date'
                                    : formatRepairDate(_completedAt!),
                              ),
                              trailing: OutlinedButton(
                                onPressed: _isSaving
                                    ? null
                                    : _pickCompletedDate,
                                child: const Text('Select'),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PartsEditor(
                    parts: _parts,
                    onAddPart: () => _editPart(),
                    onEditPart: (index) => _editPart(existingIndex: index),
                    onRemovePart: (index) {
                      setState(() => _parts.removeAt(index));
                    },
                  ),
                  const SizedBox(height: 16),
                  _AttachmentEditor(
                    attachments: _attachments,
                    onAddPhotos: _isSaving ? null : _pickImages,
                    onAddFiles: _isSaving ? null : _pickFiles,
                    onRemoveAttachment: (index) {
                      setState(() => _attachments.removeAt(index));
                    },
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
                  onPressed: _isSaving ? null : () => _save(details),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(_isEditing ? 'Save Changes' : 'Create Entry'),
                  ),
                ),
                if (_isEditing) ...[
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _isSaving ? null : () => _delete(details!),
                    child: const Text('Delete Repair'),
                  ),
                ],
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
            child: Text('Unable to load the repair entry.\n$error'),
          ),
        ),
      ),
    );
  }

  void _hydrate(RepairEntryDetails details) {
    _didHydrate = true;
    _titleController.text = details.entry.title;
    _descriptionController.text = details.entry.description ?? '';
    _area = details.entry.area;
    _urgency = details.entry.urgency ?? RepairUrgency.medium;
    _status = details.entry.status;
    _isModification = details.entry.isModification;
    _completedAt = details.entry.completedAt;
    _parts
      ..clear()
      ..addAll(details.parts.map(_PartDraft.fromExisting));
    _attachments
      ..clear()
      ..addAll(details.attachments.map(_AttachmentDraft.fromExisting));
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  Future<void> _pickCompletedDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(now.year + 2),
      initialDate: _completedAt ?? now,
    );
    if (selected == null) {
      return;
    }
    setState(() => _completedAt = selected);
  }

  Future<void> _pickImages() async {
    final media = await ref
        .read(repairControllerProvider)
        .mediaService
        .pickRepairImages();
    if (media.isEmpty) {
      return;
    }
    setState(() {
      _attachments.addAll(media.map(_AttachmentDraft.fromPicked));
    });
  }

  Future<void> _pickFiles() async {
    final media = await ref
        .read(repairControllerProvider)
        .mediaService
        .pickRepairFiles();
    if (media.isEmpty) {
      return;
    }
    setState(() {
      _attachments.addAll(media.map(_AttachmentDraft.fromPicked));
    });
  }

  Future<void> _editPart({int? existingIndex}) async {
    final existing = existingIndex == null ? null : _parts[existingIndex];

    final result = await showDialog<_PartDraft>(
      context: context,
      builder: (context) => _PartEditorDialog(
        existing: existing,
        requiredValidator: _requiredValidator,
      ),
    );

    if (result == null) {
      return;
    }

    setState(() {
      if (existingIndex == null) {
        _parts.add(result);
      } else {
        _parts[existingIndex] = result;
      }
    });
  }

  Future<void> _save(RepairEntryDetails? existingDetails) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_status.isCompleted && _completedAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose a completion date first.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    final controller = ref.read(repairControllerProvider);
    final input = RepairEntryInput(
      status: _status,
      isModification: _isModification,
      area: _area,
      urgency: _status.isPlanned
          ? (_isModification ? null : _urgency)
          : existingDetails?.entry.urgency,
      title: _titleController.text,
      description: _descriptionController.text,
      completedAt: _status.isCompleted ? _completedAt : null,
      parts: _parts
          .map((part) => RepairPartInput(title: part.title, link: part.link))
          .toList(),
    );

    try {
      if (_isEditing) {
        await controller.updateEntry(
          widget.entryId!,
          input,
          retainedAttachmentIds: _attachments
              .where((attachment) => attachment.existing != null)
              .map((attachment) => attachment.existing!.id)
              .toList(),
          newAttachments: _attachments
              .where((attachment) => attachment.picked != null)
              .map((attachment) => attachment.picked!)
              .toList(),
        );
        if (!mounted) {
          return;
        }
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(
            '/cars/${existingDetails!.entry.carProfileId}/repairs/${widget.entryId}',
          );
        }
        return;
      }

      final entryId = await controller.createEntry(
        widget.carId!,
        input,
        newAttachments: _attachments
            .where((attachment) => attachment.picked != null)
            .map((attachment) => attachment.picked!)
            .toList(),
      );

      if (!mounted) {
        return;
      }
      context.pushReplacement('/cars/${widget.carId}/repairs/$entryId');
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to save this entry.\n$error')),
      );
      setState(() => _isSaving = false);
    }
  }

  Future<void> _delete(RepairEntryDetails details) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete repair?'),
        content: const Text(
          'This will remove the entry together with its parts and attachments.',
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
      await ref.read(repairControllerProvider).deleteEntry(details);
      if (!mounted) {
        return;
      }
      context.go('/cars/${details.entry.carProfileId}/repairs');
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to delete this entry.\n$error')),
      );
      setState(() => _isSaving = false);
    }
  }
}

class _PartEditorDialog extends StatefulWidget {
  const _PartEditorDialog({
    required this.existing,
    required this.requiredValidator,
  });

  final _PartDraft? existing;
  final FormFieldValidator<String> requiredValidator;

  @override
  State<_PartEditorDialog> createState() => _PartEditorDialogState();
}

class _PartEditorDialogState extends State<_PartEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existing?.title ?? '',
    );
    _linkController = TextEditingController(text: widget.existing?.link ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final existing = widget.existing;
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      title: Text(existing == null ? 'Add Part' : 'Edit Part'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: widget.requiredValidator,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _linkController,
                decoration: const InputDecoration(
                  labelText: 'Link',
                  hintText: 'https://example.com',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            Navigator.of(context).pop(
              _PartDraft(
                id: existing?.id,
                title: _titleController.text.trim(),
                link: _normalizeOptionalText(_linkController.text),
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  String? _normalizeOptionalText(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}

class _PartsEditor extends StatelessWidget {
  const _PartsEditor({
    required this.parts,
    required this.onAddPart,
    required this.onEditPart,
    required this.onRemovePart,
  });

  final List<_PartDraft> parts;
  final VoidCallback onAddPart;
  final ValueChanged<int> onEditPart;
  final ValueChanged<int> onRemovePart;

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
                Text(
                  'Parts List',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onAddPart,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add Part'),
                ),
              ],
            ),
            if (parts.isEmpty)
              Text(
                'No parts added yet.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              )
            else
              ...parts.asMap().entries.map(
                (entry) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () => onEditPart(entry.key),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceLow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.settings_rounded),
                  ),
                  title: Text(entry.value.title),
                  subtitle: Text(entry.value.link ?? 'No link'),
                  trailing: IconButton(
                    onPressed: () => onRemovePart(entry.key),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentEditor extends StatelessWidget {
  const _AttachmentEditor({
    required this.attachments,
    required this.onAddPhotos,
    required this.onAddFiles,
    required this.onRemoveAttachment,
  });

  final List<_AttachmentDraft> attachments;
  final VoidCallback? onAddPhotos;
  final VoidCallback? onAddFiles;
  final ValueChanged<int> onRemoveAttachment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Media & Files',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onAddPhotos,
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: const Text('Add photos'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onAddFiles,
                    icon: const Icon(Icons.attach_file_rounded),
                    label: const Text('Add files'),
                  ),
                ),
              ],
            ),
            if (attachments.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: attachments.asMap().entries.map((entry) {
                  final attachment = entry.value;
                  return Stack(
                    children: [
                      Container(
                        width: attachment.kind.isImage ? 110 : 160,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceLow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: attachment.kind.isImage
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height: 72,
                                  child: Image.file(
                                    File(attachment.previewPath),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Center(
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                              ),
                                            ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  const Icon(Icons.insert_drive_file_outlined),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      attachment.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () => onRemoveAttachment(entry.key),
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PartDraft {
  const _PartDraft({required this.id, required this.title, this.link});

  factory _PartDraft.fromExisting(RepairPart part) {
    return _PartDraft(id: part.id, title: part.title, link: part.link);
  }

  final int? id;
  final String title;
  final String? link;
}

class _AttachmentDraft {
  const _AttachmentDraft._({this.existing, this.picked});

  factory _AttachmentDraft.fromExisting(RepairAttachment attachment) {
    return _AttachmentDraft._(existing: attachment);
  }

  factory _AttachmentDraft.fromPicked(PickedMediaFile file) {
    return _AttachmentDraft._(picked: file);
  }

  final RepairAttachment? existing;
  final PickedMediaFile? picked;

  String get name => existing?.originalName ?? picked!.originalName;
  String get previewPath => existing?.storedPath ?? picked!.path;
  RepairAttachmentKind get kind => existing?.kind ?? picked!.kind;
}
