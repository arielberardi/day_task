import 'package:day_task/components/app_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppNavigationBar', () {
    testWidgets('has a list of BadItem', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppNavigationBar(
            color: Colors.red,
            selectedColor: Colors.yellow,
            items: const [
              BarItemData(icon: Icons.add, label: 'Test'),
              BarItemData(icon: Icons.add, label: 'Test'),
            ],
            onChanged: (value) {},
          ),
        ),
      ));

      expect(find.byType(BarItem), findsAtLeastNWidgets(2));
    });

    testWidgets('updates index when tap on a bar item',
        (WidgetTester tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppNavigationBar(
            color: Colors.red,
            selectedColor: Colors.yellow,
            items: const [
              BarItemData(icon: Icons.add, label: 'Test'),
              BarItemData(icon: Icons.add, label: 'Test'),
            ],
            onChanged: (value) => selectedIndex = value,
          ),
        ),
      ));

      expect(selectedIndex, 0);

      await tester.tap(find.byType(BarItem).last);

      expect(selectedIndex, 1);
    });
  });

  group('BarItem', () {
    testWidgets('has a icon and label and default color',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(children: [
            BarItem(
              color: Colors.red,
              icon: Icons.add,
              label: 'Test',
              selected: false,
              onTap: () {},
            ),
          ]),
        ),
      ));

      final icon = find.byType(Icon).first;
      final color = (tester.widget(icon) as Icon).color;

      expect(color, Colors.red);
      expect(icon, findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('changes color when selected', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(children: [
            BarItem(
              color: Colors.red,
              selectedColor: Colors.yellow,
              icon: Icons.add,
              label: 'Test',
              selected: true,
              onTap: () {},
            ),
          ]),
        ),
      ));

      final icon = find.byType(Icon).first;
      final color = (tester.widget(icon) as Icon).color;

      expect(color, Colors.yellow);
    });

    testWidgets('is actionabled', (WidgetTester tester) async {
      bool actioned = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(children: [
            BarItem(
              color: Colors.red,
              selectedColor: Colors.yellow,
              icon: Icons.add,
              label: 'Test',
              selected: true,
              onTap: () => actioned = true,
            ),
          ]),
        ),
      ));

      await tester.tap(find.byType(BarItem));

      expect(actioned, true);
    });

    testWidgets('has a child', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Row(children: [
            BarItem(
              color: Colors.red,
              selected: true,
              onTap: () {},
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(''),
              ),
            ),
          ]),
        ),
      ));

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
