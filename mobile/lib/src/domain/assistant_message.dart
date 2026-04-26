import 'package:carful/src/domain/assistant_message_source.dart';

enum AssistantMessageRole { user, assistant }

class AssistantMessage {
  const AssistantMessage({
    required this.id,
    required this.carProfileId,
    required this.role,
    required this.content,
    required this.backendMessageId,
    required this.rejectionReasonCode,
    required this.sources,
    required this.createdAt,
  });

  final int id;
  final int carProfileId;
  final AssistantMessageRole role;
  final String content;
  final String? backendMessageId;
  final String? rejectionReasonCode;
  final List<AssistantMessageSource> sources;
  final DateTime createdAt;

  bool get isRejectedAssistantMessage =>
      role == AssistantMessageRole.assistant && rejectionReasonCode != null;
}
