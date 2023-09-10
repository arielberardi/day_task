import 'package:day_task/components/home_page/home_completed_tasks.dart';
import 'package:day_task/components/home_page/home_ongoing_projects.dart';
import 'package:day_task/models/member_model.dart';
import 'package:day_task/models/project_model.dart';
import 'package:day_task/models/task_model.dart';
import 'package:day_task/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:day_task/services/auth_service.dart';
import 'package:day_task/utils/router_util.dart';
import 'package:day_task/utils/ui_util.dart';
import 'package:day_task/components/home_page/home_search_section.dart';
import 'package:day_task/components/home_page/home_top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  List<Project> projects = [];
  bool taskLoading = true;
  bool projectsLoading = true;

  void signOut(BuildContext context) {
    UIUtil.showCircularSpinner(context);

    AuthService().signOut().then((_) {
      RouterUtil.resetToAuthPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);
      UIUtil.showError(
        context,
        body: error.message!,
        title: 'dialogs.error.title'.tr(),
      );
    });
  }

  void loadTasks() async {
    DbService().getAllTasks().then((tasks) {
      setState(() => tasks = tasks);
    });

    setState(() => taskLoading = false);
  }

  void loadProjects() async {
    DbService().getAllProjects().then((projects) {
      setState(() => projects = projects);
    });

    setState(() => projectsLoading = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadTasks();
    loadProjects();

    return Scaffold(
      appBar: HomeTopBar(
        member: Member(
          id: '1',
          fullName: 'Fazil Laghari',
          email: 'flaghari@gmail.com',
          avatarUrl: 'https://ui-avatars.com/api/?rounded=true',
        ),
        onTap: () => signOut(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeSearchSection(
                onFilter: () {},
                onSearch: (value) {},
              ),
              const SizedBox(height: 25.0),
              HomeCompletedTasks(
                tasks: tasks,
                isLoading: taskLoading,
              ),
              const SizedBox(height: 25.0),
              HomeOngoingProjects(
                projects: projects,
                isLoading: projectsLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
