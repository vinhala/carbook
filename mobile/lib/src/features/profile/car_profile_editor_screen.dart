import 'dart:io';

import 'package:carful/src/core/theme/app_theme.dart';
import 'package:carful/src/domain/car_profile.dart';
import 'package:carful/src/domain/car_profile_input.dart';
import 'package:carful/src/domain/mileage_reminder_frequency.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:carful/src/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CarProfileEditorScreen extends ConsumerWidget {
  const CarProfileEditorScreen({super.key, this.carId});

  final int? carId;

  bool get isEditing => carId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isEditing) {
      return const _CarProfileEditor();
    }

    final profileAsync = ref.watch(carProfileProvider(carId!));
    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return _NotFoundScaffold(message: context.l10n.carProfileNotFound);
        }
        return _CarProfileEditor(initialProfile: profile);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(context.l10n.unableToLoadCarProfile(error.toString())),
        ),
      ),
    );
  }
}

class _CarProfileEditor extends ConsumerStatefulWidget {
  const _CarProfileEditor({this.initialProfile});

  final CarProfile? initialProfile;

  @override
  ConsumerState<_CarProfileEditor> createState() => _CarProfileEditorState();
}

class _CarProfileEditorState extends ConsumerState<_CarProfileEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _makeController;
  late final TextEditingController _modelController;
  late final TextEditingController _engineController;
  late final TextEditingController _vinController;
  late final TextEditingController _mileageController;
  late DateTime _firstRegistrationMonth;
  late MileageReminderFrequency _reminderFrequency;
  late String _mileageUnit;
  String? _photoPath;
  bool _isSaving = false;

  bool get _isEditing => widget.initialProfile != null;

  @override
  void initState() {
    super.initState();
    final profile = widget.initialProfile;
    _makeController = TextEditingController(text: profile?.make ?? '');
    _modelController = TextEditingController(text: profile?.model ?? '');
    _engineController = TextEditingController(text: profile?.engine ?? '');
    _vinController = TextEditingController(text: profile?.vin ?? '');
    _mileageController = TextEditingController(
      text: profile?.currentMileage.toString() ?? '',
    );
    _firstRegistrationMonth =
        profile?.firstRegistrationMonth ??
        DateTime(DateTime.now().year, DateTime.now().month);
    _reminderFrequency =
        profile?.reminderFrequency ?? MileageReminderFrequency.monthly;
    _mileageUnit = profile?.mileageUnit ?? 'mi';
    _photoPath = profile?.photoPath;
  }

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _engineController.dispose();
    _vinController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final controller = ref.watch(carProfileControllerProvider);
    final formattedRegistration = DateFormat.yMMMM(
      localeName,
    ).format(_firstRegistrationMonth);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.editProfile : l10n.addNewCar),
        leading: _isEditing
            ? null
            : IconButton(
                tooltip: l10n.backToGarage,
                onPressed: _isSaving
                    ? null
                    : () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
            children: [
              InkWell(
                onTap: _isSaving ? null : _pickPhoto,
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: AppTheme.surfaceVariant,
                      width: 1.5,
                    ),
                    image: _photoPath != null && File(_photoPath!).existsSync()
                        ? DecorationImage(
                            image: FileImage(File(_photoPath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                    gradient: _photoPath == null
                        ? const LinearGradient(
                            colors: [
                              AppTheme.surfaceVariant,
                              AppTheme.primaryContainer,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      if (_photoPath == null)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.add_a_photo_outlined,
                                size: 48,
                                color: AppTheme.tertiary,
                              ),
                              const SizedBox(height: 12),
                              Text(l10n.tapToAddCarPhoto),
                            ],
                          ),
                        ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Row(
                          children: [
                            _CircleButton(
                              icon: Icons.photo_library_outlined,
                              onPressed: _isSaving ? null : _pickPhoto,
                            ),
                            if (_photoPath != null) ...[
                              const SizedBox(width: 8),
                              _CircleButton(
                                icon: Icons.delete_outline_rounded,
                                onPressed: _isSaving
                                    ? null
                                    : () => setState(() => _photoPath = null),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _makeController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: l10n.make),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _modelController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: l10n.model),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _engineController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: l10n.engine),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _vinController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(labelText: l10n.vin),
                        validator: _requiredValidator,
                      ),
                      const SizedBox(height: 14),
                      InkWell(
                        onTap: _isSaving ? null : _pickRegistrationMonth,
                        borderRadius: BorderRadius.circular(18),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: l10n.firstRegistration,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              const SizedBox(width: 12),
                              Text(formattedRegistration),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SegmentedButton<String>(
                        segments: [
                          ButtonSegment(value: 'mi', label: Text(l10n.miles)),
                          ButtonSegment(
                            value: 'km',
                            label: Text(l10n.kilometers),
                          ),
                        ],
                        selected: {_mileageUnit},
                        onSelectionChanged: _isSaving
                            ? null
                            : (selection) => setState(() {
                                _mileageUnit = selection.first;
                              }),
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _mileageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: l10n.currentMileage,
                          suffixText: _mileageUnit,
                        ),
                        validator: _mileageValidator,
                      ),
                    ],
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
                        l10n.mileageReminders,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.mileageReminderHelp,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: MileageReminderFrequency.values
                            .map(
                              (frequency) => ChoiceChip(
                                label: Text(frequency.localizedLabel(l10n)),
                                selected: frequency == _reminderFrequency,
                                onSelected: _isSaving
                                    ? null
                                    : (_) => setState(() {
                                        _reminderFrequency = frequency;
                                      }),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              if (_reminderFrequency.showsWarning) ...[
                const SizedBox(height: 20),
                Card(
                  color: const Color(0xFFFFF2D1),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppTheme.tertiary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _reminderFrequency == MileageReminderFrequency.never
                                ? l10n.reminderOffWarning
                                : l10n.quarterlyReminderWarning,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isSaving
                    ? null
                    : () => _saveProfile(
                        context: context,
                        controller: controller,
                      ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    _isEditing ? l10n.saveChanges : l10n.createProfile,
                  ),
                ),
              ),
              if (_isEditing) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _isSaving
                      ? null
                      : () => _confirmDelete(
                          context: context,
                          controller: controller,
                        ),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: Text(l10n.deleteProfile),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.fieldRequired;
    }
    return null;
  }

  String? _mileageValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.mileageRequired;
    }
    final mileage = int.tryParse(value);
    if (mileage == null || mileage < 0) {
      return context.l10n.mileagePositiveWholeNumber;
    }
    return null;
  }

  Future<void> _pickPhoto() async {
    final mediaService = ref.read(mediaServiceProvider);
    final path = await mediaService.pickCarImage();
    if (path != null) {
      setState(() => _photoPath = path);
    }
  }

  Future<void> _pickRegistrationMonth() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _firstRegistrationMonth,
      firstDate: DateTime(1950),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: context.l10n.selectFirstRegistrationMonth,
    );
    if (pickedDate != null) {
      setState(() {
        _firstRegistrationMonth = DateTime(pickedDate.year, pickedDate.month);
      });
    }
  }

  Future<void> _saveProfile({
    required BuildContext context,
    required CarProfileController controller,
  }) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final input = CarProfileInput(
      make: _makeController.text,
      model: _modelController.text,
      engine: _engineController.text,
      firstRegistrationMonth: _firstRegistrationMonth,
      vin: _vinController.text,
      currentMileage: int.parse(_mileageController.text),
      mileageUnit: _mileageUnit,
      photoPath: _photoPath,
      reminderFrequency: _reminderFrequency,
    );

    try {
      if (_isEditing) {
        final profile = widget.initialProfile!;
        await controller.updateProfile(
          profile.id,
          input,
          previousPhotoPath: profile.photoPath,
        );
        if (!context.mounted) {
          return;
        }
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/cars/${profile.id}');
        }
      } else {
        final profileId = await controller.createProfile(input);
        if (!context.mounted) {
          return;
        }
        context.pushReplacement('/cars/$profileId');
      }
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.unableToSaveCarProfile(error.toString())),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _confirmDelete({
    required BuildContext context,
    required CarProfileController controller,
  }) async {
    final profile = widget.initialProfile!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteProfileTitle),
        content: Text(context.l10n.deleteProfileBody),
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

    if (confirmed != true || !context.mounted) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      await controller.deleteProfile(profile);
      if (!context.mounted) {
        return;
      }
      context.go('/');
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.unableToDeleteProfile(error.toString())),
        ),
      );
      setState(() => _isSaving = false);
    }
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _NotFoundScaffold extends StatelessWidget {
  const _NotFoundScaffold({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(message)),
    );
  }
}
