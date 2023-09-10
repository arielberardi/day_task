import 'package:day_task/utils/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UIUtil#showCircularSpinner', () {
    testWidgets('shows spinner in the center', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => UIUtil.showCircularSpinner(context),
              );
            },
          ),
        )),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
    });
  });

  group('UIUtil#closeDialog', () {
    testWidgets('removes any dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(onTap: () {
                UIUtil.showCircularSpinner(context);
                UIUtil.closeDialog(context);
              });
            },
          ),
        )),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Center), findsNothing);
    });
  });

  group('UIUtil#showInfo', () {
    testWidgets('shows body title and close text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(onTap: () {
                UIUtil.showInfo(
                  context,
                  title: 'Info title',
                  body: 'Info body',
                  onTap: () {},
                );
              });
            },
          ),
        )),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Info title'), findsOneWidget);
      expect(find.text('Info body'), findsOneWidget);
    });

    testWidgets('calls onTap when pressing close', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(onTap: () {
                UIUtil.showInfo(
                  context,
                  title: 'Info title',
                  body: 'Info body',
                  onTap: () {
                    UIUtil.closeDialog(context);
                  },
                );
              });
            },
          ),
        )),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byType(TextButton));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  group('UIUtil#showError', () {
    testWidgets('shows body with localized text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(onTap: () {
                UIUtil.showError(context, title: 'Error title');
              });
            },
          ),
        )),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('errors.general'), findsOneWidget);
    });

    testWidgets('shows body with custom text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(
          body: Builder(
            builder: (context) {
              return GestureDetector(onTap: () {
                UIUtil.showError(
                  context,
                  title: 'Error title',
                  body: 'Error body',
                );
              });
            },
          ),
        )),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Error body'), findsOneWidget);
    });
  });
}
