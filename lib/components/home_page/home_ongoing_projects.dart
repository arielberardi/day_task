import 'package:day_task/components/link_text.dart';
import 'package:day_task/components/project_card.dart';
import 'package:day_task/models/project_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeOngoingProjects extends StatelessWidget {
  final List<Project> projects;
  final bool isLoading;

  const HomeOngoingProjects({
    super.key,
    required this.projects,
    this.isLoading = false,
  });

  List<Widget> getContentWidget() {
    if (isLoading) {
      return [const CircularProgressIndicator()];
    } else if (!isLoading && projects.isEmpty) {
      return [Text('pages.home.emptyProjects'.tr())];
    } else {
      return List.generate(
        projects.length.clamp(1, 5),
        (index) {
          return Column(
            children: [
              ProjectCard(projects[index]),
              const SizedBox(height: 10.0),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'pages.home.ongoingProjects'.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      letterSpacing: 1.5,
                    ),
              ),
              LinkText(
                'pages.home.seeAll'.tr(),
                onTap: () => debugPrint('Go to See All projects'),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Column(children: getContentWidget()),
        ],
      ),
    );
  }
}
