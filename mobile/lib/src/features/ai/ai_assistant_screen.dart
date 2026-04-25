import 'package:carbook/src/core/theme/app_theme.dart';
import 'package:carbook/src/domain/assistant_message.dart';
import 'package:carbook/src/domain/assistant_message_source.dart';
import 'package:carbook/src/features/ai/ai_assistant_controller.dart';
import 'package:carbook/src/features/profile/car_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                      'Ask about this car, its workshop manuals, maintenance, repairs, and troubleshooting.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: messagesAsync.when(
                data: (messages) => _MessageList(messages: messages),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Unable to load AI assistant.\n$error'),
                  ),
                ),
              ),
            ),
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
      if (!mounted) {
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
                  .map<Widget>(
                    (source) => Chip(
                      label: Text(
                        source.citation == null
                            ? source.label
                            : '${source.label} • ${source.citation}',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
