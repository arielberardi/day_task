import 'package:day_task/models/project_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.name,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  letterSpacing: 1,
                ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'components.teamMembers'.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 50,
                    height: 25,
                    child: Stack(
                      children: List.generate(
                        project.members.length > 5 ? 5 : project.members.length,
                        (index) {
                          return Positioned(
                            top: 1.5,
                            child: CircleAvatar(
                              radius: 7.5,
                              backgroundImage: NetworkImage(
                                  project.members[index].avatarUrl),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    '${'components.projectCard.dueOn'.tr()} ${project.dueOn}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 25,
                lineWidth: 2,
                progressColor: Colors.yellow,
                backgroundColor: Colors.black,
                percent: project.progress / 100,
                center: Text(
                  '${project.progress.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
