import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormPasswordField extends StatefulWidget {
  const FormPasswordField({super.key});

  @override
  State<FormPasswordField> createState() => _FormPasswordFieldState();
}

class _FormPasswordFieldState extends State<FormPasswordField> {
  bool textVisible = false;

  String? validatorPassword(String value) {
    RegExp expresion = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[A-Z])');

    if (!expresion.hasMatch(value)) {
      return 'form.errors.password'.tr();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      obscureText: !textVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        label: Text('form.password'.tr()),
        icon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            textVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() => textVisible = !textVisible);
          },
        ),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'form.errors.required'.tr(args: ['Password']),
        ),
        FormBuilderValidators.minLength(
          8,
          errorText: 'form.errors.minLength'.tr(args: ['8']),
        ),
        (value) => validatorPassword(value!),
      ]),
    );
  }
}
