import 'package:carful/src/domain/assistant_message_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses old source json without optional citation fields', () {
    final source = AssistantMessageSource.fromJson({
      'label': 'Tacoma Manual.pdf',
      'kind': 'manual',
      'citation': 'Page 142',
    });

    expect(source.label, 'Tacoma Manual.pdf');
    expect(source.kind, 'manual');
    expect(source.displayLabel, 'Tacoma Manual.pdf • Page 142');
    expect(source.sourceId, isNull);
    expect(source.quote, isNull);
  });

  test('round-trips new structured source json fields', () {
    const source = AssistantMessageSource(
      label: 'Toyota service info',
      kind: 'web',
      citation: 'Oil reference',
      url: 'https://example.com/service',
      sourceId: 'https://example.com/service',
      quote: 'Use the listed oil viscosity.',
    );

    final parsed = AssistantMessageSource.fromJson(source.toJson());

    expect(parsed.label, source.label);
    expect(parsed.kind, source.kind);
    expect(parsed.citation, source.citation);
    expect(parsed.url, source.url);
    expect(parsed.sourceId, source.sourceId);
    expect(parsed.quote, source.quote);
    expect(parsed.displayLabel, 'Toyota service info • Oil reference');
  });
}
