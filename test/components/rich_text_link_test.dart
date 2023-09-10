import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day_task/components/rich_text_link.dart';

void main() {
  group('RichTextLink', () {
    testWidgets('requires only a linkText', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RichTextLink(
            linkText: 'Link Text',
            onTap: () => pressed = true,
          ),
        ),
      ));

      await tester.tap(find.byType(RichTextLink));

      expect(pressed, true);
    });

    testWidgets('is actionable', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RichTextLink(
            text: 'Text ',
            linkText: 'Link Text',
            onTap: () => pressed = true,
          ),
        ),
      ));

      await tester.tap(find.byType(RichTextLink));

      expect(pressed, true);
    });
  });
}
