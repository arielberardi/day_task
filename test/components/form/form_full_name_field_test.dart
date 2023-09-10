import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:day_task/components/form/form_full_name_field.dart';

void main() {
  group('FormFullNameField', () {
    testWidgets('validates required', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormFullNameField(),
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

    testWidgets('validetes format', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormFullNameField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      final textField = find.byType(FormFullNameField);
      await tester.enterText(textField, 'test');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.minWords'), findsOneWidget);
    });

    testWidgets('submits with valid full name', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormFullNameField(),
                ElevatedButton(
                  onPressed: () => formKey.currentState?.saveAndValidate(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      final textField = find.byType(FormFullNameField);
      await tester.enterText(textField, 'Test Example');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('form.errors.required'), findsNothing);
      expect(find.text('form.errors.maxWords'), findsNothing);
    });
  });
}
