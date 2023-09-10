import 'package:day_task/utils/router_util.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:day_task/components/button_auth.dart';
import 'package:day_task/services/auth_service.dart';
import 'package:day_task/utils/ui_util.dart';

class AuthButtonsCollection extends StatelessWidget {
  const AuthButtonsCollection({super.key});

  void signInWithGoogle(BuildContext context) {
    UIUtil.showCircularSpinner(context);

    AuthService().signInWithGoogle().then((_) {
      RouterUtil.resetToAuthPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);
      UIUtil.showError(
        context,
        body: parseError(error),
        title: 'dialogs.error.title'.tr(),
      );
    });
  }

  void signInWithFacebook(BuildContext context) {
    UIUtil.showCircularSpinner(context);

    AuthService().signInWithFacebook().then((_) {
      RouterUtil.resetToAuthPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);
      UIUtil.showError(
        context,
        body: parseError(error),
        title: 'dialogs.error.title'.tr(),
      );
    });
  }

  String parseError(dynamic error) {
    return switch (error.code) {
      'user-not-found' => 'errors.userNotFound'.tr(),
      'invalid-credential' || 'wrong-password' => 'errors.wrongPassword'.tr(),
      'user-disabled' => 'errors.userDisabled'.tr(),
      'account-exists-with-different-credential' =>
        'errors.emailAlreadyInUse'.tr(),
      _ => error.message!
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonAuth(
          imagePath: 'lib/assets/images/google.png',
          onTap: () => signInWithGoogle(context),
        ),
        const SizedBox(width: 25.0),
        ButtonAuth(
          imagePath: 'lib/assets/images/facebook.png',
          onTap: () => signInWithFacebook(context),
        ),
      ],
    );
  }
}
