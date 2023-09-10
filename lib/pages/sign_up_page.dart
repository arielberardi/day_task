import 'package:day_task/components/form/form_email_field.dart';
import 'package:day_task/components/form/form_full_name_field.dart';
import 'package:day_task/components/form/form_password_field.dart';
import 'package:day_task/components/form/form_toc_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:day_task/components/button_auth_collection.dart';
import 'package:day_task/components/divider_text.dart';
import 'package:day_task/components/logo.dart';
import 'package:day_task/components/rich_text_link.dart';
import 'package:day_task/services/auth_service.dart';
import 'package:day_task/utils/router_util.dart';
import 'package:day_task/utils/ui_util.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  SignUpPage({super.key});

  void signUn(BuildContext context, Map<String, dynamic>? values) {
    UIUtil.showCircularSpinner(context);

    AuthService()
        .signUp(values!['email'], values['password'], values['fullName'])
        .then((_) {
      UIUtil.closeDialog(context);
      UIUtil.showInfo(
        context,
        body: 'dialogs.email.body'.tr(),
        title: 'dialogs.email.title'.tr(),
        onTap: () => RouterUtil.resetToAuthPage(context),
      );
    }).catchError((error) {
      UIUtil.closeDialog(context);

      String errorMessage = switch (error.code) {
        'email-already-in-use' => 'errors.emailAlreadyInUse'.tr(),
        _ => error.message!
      };

      UIUtil.showError(
        context,
        body: errorMessage,
        title: 'dialogs.error.title'.tr(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Logo(height: 125, width: 125)), // Logo
                const SizedBox(height: 10.0),
                Text(
                  'pages.signUp.title'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 25.0),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      const FormFullNameField(),
                      const SizedBox(height: 15.0),
                      const FormEmailField(),
                      const SizedBox(height: 15.0),
                      const FormPasswordField(),
                      const FormToCCheckbox(),
                      const SizedBox(height: 25.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ==
                              true) {
                            signUn(context, _formKey.currentState?.value);
                          }
                        },
                        child: Text('signUp'.tr()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                DividerText('divider'.tr()),
                const SizedBox(height: 30.0),
                const AuthButtonsCollection(),
                const SizedBox(height: 25.0),
                Container(
                  alignment: Alignment.center,
                  child: RichTextLink(
                    text: 'pages.signUp.alreadyAccount'.tr(),
                    linkText: 'signIn'.tr(),
                    onTap: () => RouterUtil.navigateBack(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
