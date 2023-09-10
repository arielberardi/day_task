import 'package:day_task/pages/auth_page.dart';
import 'package:day_task/pages/forgot_password_page.dart';
import 'package:day_task/pages/sign_in_page.dart';
import 'package:day_task/pages/sign_up_page.dart';
import 'package:day_task/pages/welcome_page.dart';
import 'package:flutter/material.dart';

enum Pages {
  auth,
  welcome,
  signUp,
  signIn,
  forgotPassword,
  home,
}

class RouterUtil {
  static final Map<Pages, Widget> pages = {
    Pages.auth: const AuthPage(),
    Pages.welcome: const WelcomePage(),
    Pages.signUp: SignUpPage(),
    Pages.signIn: SignInPage(),
    Pages.forgotPassword: ForgotPasswordPage(),
  };

  static void navigateTo(BuildContext context, Pages page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => pages[page]!),
    );
  }

  static void resetTo(BuildContext context, Pages page) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => pages[page]!),
      (Route<dynamic> route) => false,
    );
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void resetToAuthPage(BuildContext context) {
    resetTo(context, Pages.auth);
  }
}
