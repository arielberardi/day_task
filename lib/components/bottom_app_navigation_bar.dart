import 'package:flutter/material.dart';
import 'package:day_task/components/app_navigation_bar.dart';

class BottomAppNavigationBar extends StatelessWidget {
  final Function(int) onChange;

  const BottomAppNavigationBar({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return AppNavigationBar(
      color: Theme.of(context).colorScheme.secondary,
      selectedColor: Theme.of(context).colorScheme.primary,
      onChanged: onChange,
      items: [
        const BarItemData(
          icon: Icons.home,
          label: 'Home',
        ),
        const BarItemData(
          icon: Icons.chat_bubble,
          label: 'Chat',
        ),
        BarItemData(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              child: Container(
                color: Colors.yellow,
                child: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                ),
              )),
        ),
        const BarItemData(
          icon: Icons.calendar_month_outlined,
          label: 'Calendar',
        ),
        const BarItemData(
          icon: Icons.notifications_outlined,
          label: 'Notification',
        ),
      ],
    );
  }
}
