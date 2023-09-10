import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormFullNameField extends StatelessWidget {
  const FormFullNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'fullName',
      decoration: InputDecoration(
        label: Text('form.fullName'.tr()),
        icon: const Icon(Icons.person_outline),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'form.errors.required'.tr(args: ['Full Name']),
        ),
        FormBuilderValidators.minWordsCount(
          2,
          errorText: 'form.errors.minWords'.tr(args: ['2']),
        ),
      ]),
    );
  }
}
