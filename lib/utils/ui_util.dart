import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UIUtil {
  static void showCircularSpinner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showInfo(
    context, {
    required String body,
    required String title,
    required Function() onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: onTap,
              child: Text(
                'close'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        );
      },
    );
  }

  static void showError(context, {String? body, required String title}) {
    showInfo(
      context,
      body: body ?? 'errors.general'.tr(),
      title: title,
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
