import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormEmailField extends StatelessWidget {
  const FormEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'email',
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        label: Text('form.email'.tr()),
        icon: const Icon(Icons.person_pin_outlined),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'form.errors.required'.tr(args: ['Email']),
        ),
        FormBuilderValidators.email(
          errorText: 'form.errors.invalidFormat'.tr(),
        ),
      ]),
    );
  }
}
