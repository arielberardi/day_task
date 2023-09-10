import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day_task/components/link_text.dart';

void main() {
  group('LinkText', () {
    testWidgets('is actionable', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: LinkText(
            'example',
            onTap: () => pressed = true,
          ),
        ),
      ));

      await tester.tap(find.byType(LinkText));

      expect(pressed, true);
    });
  });
}
