import 'package:day_task/components/form/form_email_field.dart';
import 'package:day_task/utils/router_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:day_task/components/logo.dart';
import 'package:day_task/services/auth_service.dart';
import 'package:day_task/utils/ui_util.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  ForgotPasswordPage({super.key});

  void forgotPassword(BuildContext context, Map<String, dynamic>? values) {
    UIUtil.showCircularSpinner(context);

    AuthService().forgotPassword(values!['email']).then((_) {
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
        'user-not-found' => 'errors.userNotFound'.tr(),
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Logo(height: 125, width: 125)),
              const SizedBox(height: 10.0),
              Text(
                'pages.forgotPassword.title'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 25.0),
              const Text('pages.forgotPassword.instructions').tr(),
              const SizedBox(height: 25.0),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const FormEmailField(),
                    const SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() == true) {
                          forgotPassword(context, _formKey.currentState?.value);
                        }
                      },
                      child: Text('pages.forgotPassword.button'.tr()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
