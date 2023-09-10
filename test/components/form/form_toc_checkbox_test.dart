import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:day_task/components/form/form_toc_checkbox.dart';

void main() {
  group('FormToCCheckbox', () {
    testWidgets('validates required', (WidgetTester tester) async {
      final formKey = GlobalKey<FormBuilderState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                const FormToCCheckbox(),
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

      expect(find.text('form.errors.requiredChecked'), findsOneWidget);
    });
  });
}
