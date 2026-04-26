import 'package:carful/src/core/theme/app_theme.dart';
import 'package:carful/src/domain/assistant_message.dart';
import 'package:carful/src/domain/assistant_message_source.dart';
import 'package:carful/src/features/ai/ai_assistant_controller.dart';
import 'package:carful/src/features/profile/car_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AiAssistantScreen extends ConsumerStatefulWidget {
  const AiAssistantScreen({super.key, required this.carId});

  final int? carId;

  @override
  ConsumerState<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends ConsumerState<AiAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carId = widget.carId;
    if (carId == null) {
      return const Scaffold(body: Center(child: Text('Invalid AI assistant.')));
    }

    final profileAsync = ref.watch(carProfileProvider(carId));
    final messagesAsync = ref.watch(assistantMessagesProvider(carId));
    final manualsAsync = ref.watch(workshopManualsProvider(carId));
    final hasManuals = manualsAsync.asData?.value.isNotEmpty ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(profileAsync.asData?.value?.displayName ?? 'AI Assistant'),
      ),
      body: SafeArea(
        child: Column(
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
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.smart_toy_outlined,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      hasManuals
                          ? 'Ask about this car, its workshop manuals, maintenance, repairs, and troubleshooting.'
                          : 'Add at least one workshop manual to start using the assistant.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: manualsAsync.when(
                data: (manuals) {
                  if (manuals.isEmpty) {
                    return const _AssistantDisabledState();
                  }

                  return messagesAsync.when(
                    data: (messages) => _MessageList(messages: messages),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text('Unable to load AI assistant.\n$error'),
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Unable to load workshop manuals.\n$error'),
                  ),
                ),
              ),
            ),
            if (hasManuals)
              SafeArea(
                top: false,
                minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        key: const ValueKey('assistant-message-field'),
                        controller: _controller,
                        minLines: 1,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText:
                              'Ask about maintenance, specs, or procedures...',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      key: const ValueKey('assistant-send-button'),
                      onPressed: _isSending
                          ? null
                          : () => _sendMessage(context, carId),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(56, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: _isSending
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage(BuildContext context, int carId) async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() => _isSending = true);
    _controller.clear();
    try {
      await ref.read(aiAssistantControllerProvider).sendMessage(carId, text);
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to send message.\n$error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }
}

class _AssistantDisabledState extends StatelessWidget {
  const _AssistantDisabledState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.picture_as_pdf_outlined,
                color: AppTheme.primary,
                size: 36,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Add at least one workshop manual to start using the assistant.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({required this.messages});

  final List<AssistantMessage> messages;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _AssistantBubble(
            message:
                'Hello. I have your workshop manuals loaded. What are we tackling today?',
            sources: [],
            isRejected: false,
          ),
        ],
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: messages.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final message = messages[index];
        return Align(
          alignment: message.role == AssistantMessageRole.user
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: message.role == AssistantMessageRole.user
              ? _UserBubble(message: message.content)
              : _AssistantBubble(
                  message: message.content,
                  sources: message.sources,
                  isRejected: message.isRejectedAssistantMessage,
                ),
        );
      },
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.tertiary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.white),
      ),
    );
  }
}

class _AssistantBubble extends StatelessWidget {
  const _AssistantBubble({
    required this.message,
    required this.sources,
    required this.isRejected,
  });

  final String message;
  final List<AssistantMessageSource> sources;
  final bool isRejected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 340),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRejected ? AppTheme.surfaceLow : AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(22),
        border: isRejected ? Border.all(color: AppTheme.secondary) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: Theme.of(context).textTheme.bodyLarge),
          if (sources.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: sources
                  .map<Widget>((source) => _SourceChip(source: source))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _SourceChip extends StatelessWidget {
  const _SourceChip({required this.source});

  final AssistantMessageSource source;

  @override
  Widget build(BuildContext context) {
    final url = source.url;
    if (source.kind == 'web' && url != null && url.isNotEmpty) {
      return ActionChip(
        label: Text(source.displayLabel),
        onPressed: () => launchUrl(Uri.parse(url)),
      );
    }
    return Chip(label: Text(source.displayLabel));
  }
}
