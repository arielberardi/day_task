import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:day_task/components/team_members_list.dart';
import 'package:day_task/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(10.0),
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              task.name,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('components.teamMembers'.tr(),
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 5.0),
              AvatarMembersList(members: task.members),
            ],
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  (task.progress >= 100)
                      ? 'components.taskCard.completed'.tr()
                      : 'components.taskCard.progress'.tr(),
                  style: Theme.of(context).textTheme.bodySmall),
              Text('${task.progress.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 5.0),
          LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: task.progress / 100.0,
            color: Colors.black,
            minHeight: 5,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
