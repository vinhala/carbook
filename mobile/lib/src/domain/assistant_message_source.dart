class AssistantMessageSource {
  const AssistantMessageSource({
    required this.label,
    required this.kind,
    this.citation,
    this.url,
    this.sourceId,
    this.quote,
  });

  final String label;
  final String kind;
  final String? citation;
  final String? url;
  final String? sourceId;
  final String? quote;

  String get displayLabel =>
      citation == null || citation!.isEmpty ? label : '$label • $citation';

  Map<String, Object?> toJson() => {
    'label': label,
    'kind': kind,
    'citation': citation,
    'url': url,
    'source_id': sourceId,
    'quote': quote,
  };

  factory AssistantMessageSource.fromJson(Map<String, Object?> json) {
    return AssistantMessageSource(
      label: json['label'] as String? ?? '',
      kind: json['kind'] as String? ?? 'manual',
      citation: json['citation'] as String?,
      url: json['url'] as String?,
      sourceId: json['source_id'] as String?,
      quote: json['quote'] as String?,
    );
  }
}
