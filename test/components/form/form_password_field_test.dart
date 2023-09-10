import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:day_task/components/form/form_password_field.dart';

void main() {
  group('FormPasswordField', () {
    testWidgets('validates required', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormPasswordField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.required'), findsOneWidget);
    });

    testWidgets('validetes lenghts', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormPasswordField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      final textField = find.byType(FormPasswordField);
      await tester.enterText(textField, 'T123@!');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.minLength'), findsOneWidget);
    });

    testWidgets('validetes format', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormPasswordField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      final textField = find.byType(FormPasswordField);
      await tester.enterText(textField, 'Test12345');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.password'), findsOneWidget);
    });

    testWidgets('submits with valid password', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormPasswordField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      final textField = find.byType(FormPasswordField);
      await tester.enterText(textField, 'Test12345@!');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.required'), findsNothing);
      expect(find.text('form.errors.minLength'), findsNothing);
      expect(find.text('form.errors.password'), findsNothing);
    });
  });
}
