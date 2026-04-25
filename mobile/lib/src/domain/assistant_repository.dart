import 'package:carbook/src/domain/assistant_message.dart';
import 'package:carbook/src/domain/assistant_message_source.dart';

abstract class AssistantRepository {
  Stream<List<AssistantMessage>> watchMessages(int carProfileId);
  Future<List<AssistantMessage>> listMessages(int carProfileId);
  Future<String?> getConversationId(int carProfileId);
  Future<void> saveConversationId(int carProfileId, String? conversationId);
  Future<int> addMessage({
    required int carProfileId,
    required AssistantMessageRole role,
    required String content,
    String? backendMessageId,
    String? rejectionReasonCode,
    List<AssistantMessageSource> sources = const [],
  });
}
