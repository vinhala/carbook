import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/domain/ai_schedule_suggestion.dart';
import 'package:carbook/src/features/ai/ai_assistant_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MaintenanceAiSuggestionsScreen extends ConsumerStatefulWidget {
  const MaintenanceAiSuggestionsScreen({super.key, required this.carId});

  final int? carId;

  @override
  ConsumerState<MaintenanceAiSuggestionsScreen> createState() =>
      _MaintenanceAiSuggestionsScreenState();
}

class _MaintenanceAiSuggestionsScreenState
    extends ConsumerState<MaintenanceAiSuggestionsScreen> {
  final Set<int> _selectedIndexes = <int>{};
  bool _initializedSelection = false;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final carId = widget.carId;
    if (carId == null) {
      return const Scaffold(
        body: Center(child: Text('Invalid AI maintenance suggestions.')),
      );
    }

    final suggestionsAsync = ref.watch(maintenanceSuggestionsProvider(carId));

    return Scaffold(
      appBar: AppBar(title: const Text('Suggested Schedule')),
      body: SafeArea(
        child: suggestionsAsync.when(
          data: (suggestions) {
            if (!_initializedSelection) {
              _selectedIndexes.addAll(
                suggestions
                    .asMap()
                    .entries
                    .where((entry) => entry.value.selectedByDefault)
                    .map((entry) => entry.key),
              );
              _initializedSelection = true;
            }

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceLow,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.surfaceVariant),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI Advisor is analyzing...',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Select the recommended maintenance items to add to your vehicle tracker.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppTheme.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: suggestions.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final suggestion = suggestions[index];
                      final selected = _selectedIndexes.contains(index);
                      return InkWell(
                        onTap: () => setState(() {
                          if (selected) {
                            _selectedIndexes.remove(index);
                          } else {
                            _selectedIndexes.add(index);
                          }
                        }),
                        borderRadius: BorderRadius.circular(24),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: selected,
                                  onChanged: (_) => setState(() {
                                    if (selected) {
                                      _selectedIndexes.remove(index);
                                    } else {
                                      _selectedIndexes.add(index);
                                    }
                                  }),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _SuggestionBody(
                                    suggestion: suggestion,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      key: const ValueKey('confirm-ai-suggestions-button'),
                      onPressed: _isSaving || _selectedIndexes.isEmpty
                          ? null
                          : () => _confirmSuggestions(
                              context,
                              carId,
                              suggestions,
                            ),
                      icon: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(
                              Icons.playlist_add_check_circle_outlined,
                            ),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Confirm & Add to Schedule'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Unable to generate AI suggestions.\n$error'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmSuggestions(
    BuildContext context,
    int carId,
    List<AiScheduleSuggestion> suggestions,
  ) async {
    setState(() => _isSaving = true);
    try {
      await ref
          .read(aiAssistantControllerProvider)
          .applySuggestions(
            carId,
            _selectedIndexes.map((index) => suggestions[index]).toList(),
          );
      if (!mounted) {
        return;
      }
      context.pop();
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to add suggestions.\n$error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

class _SuggestionBody extends StatelessWidget {
  const _SuggestionBody({required this.suggestion});

  final AiScheduleSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          suggestion.title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          suggestion.description,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(
              label: Text(
                '${suggestion.intervalValue} ${suggestion.scheduleType == 'time' ? suggestion.timeUnit ?? 'weeks' : 'mi'}',
              ),
            ),
            Chip(label: Text('${suggestion.priority.toUpperCase()} priority')),
            if (suggestion.manualReference != null)
              Chip(label: Text(suggestion.manualReference!)),
          ],
        ),
      ],
    );
  }
}
