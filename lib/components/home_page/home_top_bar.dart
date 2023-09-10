import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:day_task/models/member_model.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  final Member member;
  final double height;
  final VoidCallback? onTap;

  const HomeTopBar({
    super.key,
    required this.member,
    this.onTap,
    this.height = 60.0,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: RichText(
          text: TextSpan(
            text: '${'pages.home.welcomeBack'.tr()}\n',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  height: 2,
                ),
            children: [
              TextSpan(
                text: member.fullName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      letterSpacing: 1.5,
                    ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 6.0, 20, 6.0),
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(member.avatarUrl),
            ),
          ),
        ),
      ],
    );
  }
}
