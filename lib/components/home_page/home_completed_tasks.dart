import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:day_task/components/link_text.dart';
import 'package:day_task/components/task_card.dart';
import 'package:day_task/models/task_model.dart';

class HomeCompletedTasks extends StatelessWidget {
  final List<Task> tasks;
  final bool isLoading;

  const HomeCompletedTasks({
    super.key,
    required this.tasks,
    this.isLoading = false,
  });

  Widget getContentWidget() {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else if (!isLoading && tasks.isEmpty) {
      return Text('pages.home.emptyTasks'.tr());
    } else {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.antiAlias,
        itemCount: tasks.length.clamp(1, 5),
        itemBuilder: (context, index) => TaskCard(tasks[index]),
        separatorBuilder: (context, index) => const SizedBox(width: 5.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'pages.home.completedTasks'.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      letterSpacing: 1.5,
                    ),
              ),
              LinkText(
                'pages.home.seeAll'.tr(),
                onTap: () => debugPrint('Go to See All completed tasks'),
              ),
            ],
          ),
        ),
        Container(
          height: isLoading ? 65 : 175.0,
          padding: const EdgeInsets.fromLTRB(25.0, 10.0, 0, 0.0),
          child: getContentWidget(),
        ),
      ],
    );
  }
}
