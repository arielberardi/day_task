import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day_task/components/button_auth.dart';

void main() {
  group('ButtonAuth', () {
    testWidgets('contains an image', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ButtonAuth(
            imagePath: 'lib/assets/images/google.png',
            onTap: () {},
          ),
        ),
      ));

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('is actionable', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ButtonAuth(
            imagePath: 'lib/assets/images/google.png',
            onTap: () => pressed = true,
          ),
        ),
      ));

      await tester.tap(find.byType(ButtonAuth));

      expect(pressed, true);
    });
  });
}
