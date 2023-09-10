import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:day_task/components/logo.dart';
import 'package:day_task/utils/router_util.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Logo(width: 100, height: 100),
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      'lib/assets/images/work_in_progress.png',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'pages.welcome.title'.tr(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    TextSpan(
                      text: '\nDayTask',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => RouterUtil.navigateTo(context, Pages.signIn),
                child: Text('pages.welcome.button'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
