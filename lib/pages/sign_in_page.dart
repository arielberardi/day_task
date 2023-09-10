import 'package:day_task/components/form/form_email_field.dart';
import 'package:day_task/components/form/form_password_field.dart';
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

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  SignInPage({super.key});

  void signIn(BuildContext context, Map<String, dynamic>? values) {
    UIUtil.showCircularSpinner(context);

    AuthService().signIn(values!['email'], values['password']).then((_) {
      RouterUtil.resetToAuthPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);

      String errorMessage = switch (error.code) {
        'user-not-found' => 'errors.userNotFound'.tr(),
        'wrong-password' => 'errors.wrongPassword'.tr(),
        'user-disabled' => 'errors.userDisabled'.tr(),
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
                const Center(child: Logo(height: 125, width: 125)),
                const SizedBox(height: 10.0),
                Text(
                  'pages.signIn.title'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 15.0),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      const FormEmailField(),
                      const SizedBox(height: 15.0),
                      const FormPasswordField(),
                      const SizedBox(height: 15.0),
                      Container(
                        alignment: Alignment.centerRight,
                        child: RichTextLink(
                            linkText: 'pages.signIn.forgotPassword'.tr(),
                            onTap: () {
                              RouterUtil.navigateTo(
                                context,
                                Pages.forgotPassword,
                              );
                            }),
                      ),
                      const SizedBox(height: 15.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ==
                              true) {
                            signIn(context, _formKey.currentState?.value);
                          }
                        },
                        child: Text('signIn'.tr()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                DividerText('divider'.tr()),
                const SizedBox(height: 25.0),
                const AuthButtonsCollection(),
                const SizedBox(height: 25.0),
                Container(
                  alignment: Alignment.center,
                  child: RichTextLink(
                    text: 'pages.signIn.notRegistered'.tr(),
                    linkText: 'signUp'.tr(),
                    onTap: () => RouterUtil.navigateTo(context, Pages.signUp),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
