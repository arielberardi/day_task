import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:day_task/components/rich_text_link.dart';

class FormToCCheckbox extends StatelessWidget {
  const FormToCCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: 'toc',
      initialValue: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      checkColor: Theme.of(context).colorScheme.primary,
      activeColor: Colors.transparent,
      side: MaterialStateBorderSide.resolveWith(
        (states) {
          return BorderSide(
            width: 1.5,
            color: Theme.of(context).colorScheme.primary,
          );
        },
      ),
      title: RichTextLink(
        text: 'pages.signUp.toc'.tr(),
        linkText: 'pages.signUp.tocLink'.tr(),
        onTap: () => launchUrl(Uri.parse('https://flutter.dev')),
      ),
      validator: (value) {
        String error = 'form.errors.requiredChecked'.tr(
          args: ['Terms and Conditions'],
        );
        return value == false ? error : null;
      },
    );
  }
}
