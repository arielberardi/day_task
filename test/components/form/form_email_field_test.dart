import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:day_task/components/form/form_email_field.dart';

void main() {
  group('FormEmailField', () {
    testWidgets('validates required', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormEmailField(),
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

    testWidgets('validates format', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormEmailField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      final textField = find.byType(FormBuilderTextField);
      await tester.enterText(textField, 'test');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.invalidFormat'), findsOneWidget);
    });

    testWidgets('submits with valid email', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormEmailField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      final textField = find.byType(FormBuilderTextField);
      await tester.enterText(textField, 'test@example.com');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.required'), findsNothing);
      expect(find.text('form.errors.invalidFormat'), findsNothing);
    });
  });
}
