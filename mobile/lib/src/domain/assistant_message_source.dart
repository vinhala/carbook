class AssistantMessageSource {
  const AssistantMessageSource({
    required this.label,
    required this.kind,
    this.citation,
    this.url,
  });

  final String label;
  final String kind;
  final String? citation;
  final String? url;

  Map<String, Object?> toJson() => {
    'label': label,
    'kind': kind,
    'citation': citation,
    'url': url,
  };

  factory AssistantMessageSource.fromJson(Map<String, Object?> json) {
    return AssistantMessageSource(
      label: json['label'] as String? ?? '',
      kind: json['kind'] as String? ?? 'manual',
      citation: json['citation'] as String?,
      url: json['url'] as String?,
    );
  }
}
