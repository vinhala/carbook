import 'dart:convert';

import 'package:carbook/src/data/local/app_database.dart';
import 'package:carbook/src/domain/assistant_message.dart';
import 'package:carbook/src/domain/assistant_message_source.dart';
import 'package:carbook/src/domain/assistant_repository.dart';
import 'package:drift/drift.dart';

class DriftAssistantRepository implements AssistantRepository {
  DriftAssistantRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<List<AssistantMessage>> watchMessages(int carProfileId) {
    final query = _database.select(_database.assistantMessages)
      ..where((table) => table.carProfileId.equals(carProfileId))
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.createdAt, mode: OrderingMode.asc),
        (table) => OrderingTerm(expression: table.id, mode: OrderingMode.asc),
      ]);
    return query.watch().map((rows) => rows.map(_mapMessage).toList());
  }

  @override
  Future<List<AssistantMessage>> listMessages(int carProfileId) async {
    final query = _database.select(_database.assistantMessages)
      ..where((table) => table.carProfileId.equals(carProfileId))
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.createdAt, mode: OrderingMode.asc),
        (table) => OrderingTerm(expression: table.id, mode: OrderingMode.asc),
      ]);
    final rows = await query.get();
    return rows.map(_mapMessage).toList();
  }

  @override
  Future<String?> getConversationId(int carProfileId) async {
    final query = _database.select(_database.assistantConversations)
      ..where((table) => table.carProfileId.equals(carProfileId));
    final row = await query.getSingleOrNull();
    return row?.conversationId;
  }

  @override
  Future<void> saveConversationId(
    int carProfileId,
    String? conversationId,
  ) async {
    final now = DateTime.now();
    final query = _database.select(_database.assistantConversations)
      ..where((table) => table.carProfileId.equals(carProfileId));
    final existing = await query.getSingleOrNull();
    if (existing == null) {
      await _database
          .into(_database.assistantConversations)
          .insert(
            AssistantConversationsCompanion.insert(
              carProfileId: carProfileId,
              conversationId: Value(conversationId),
              createdAt: now,
              updatedAt: now,
            ),
          );
      return;
    }

    await (_database.update(
      _database.assistantConversations,
    )..where((table) => table.id.equals(existing.id))).write(
      AssistantConversationsCompanion(
        conversationId: Value(conversationId),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<int> addMessage({
    required int carProfileId,
    required AssistantMessageRole role,
    required String content,
    String? backendMessageId,
    String? rejectionReasonCode,
    List<AssistantMessageSource> sources = const [],
  }) {
    return _database
        .into(_database.assistantMessages)
        .insert(
          AssistantMessagesCompanion.insert(
            carProfileId: carProfileId,
            role: role.name,
            content: content,
            backendMessageId: Value(backendMessageId),
            rejectionReasonCode: Value(rejectionReasonCode),
            sourcesJson: Value(
              jsonEncode(sources.map((source) => source.toJson()).toList()),
            ),
            createdAt: DateTime.now(),
          ),
        );
  }

  AssistantMessage _mapMessage(AssistantMessageRecord record) {
    final rawSources = (jsonDecode(record.sourcesJson ?? '[]') as List<Object?>)
        .cast<Map<String, Object?>>();
    return AssistantMessage(
      id: record.id,
      carProfileId: record.carProfileId,
      role: record.role == AssistantMessageRole.user.name
          ? AssistantMessageRole.user
          : AssistantMessageRole.assistant,
      content: record.content,
      backendMessageId: record.backendMessageId,
      rejectionReasonCode: record.rejectionReasonCode,
      sources: rawSources.map(AssistantMessageSource.fromJson).toList(),
      createdAt: record.createdAt,
    );
  }
}
