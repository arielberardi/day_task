import 'package:day_task/models/member_model.dart';
import 'package:day_task/models/task_model.dart';

class Project {
  late String id;
  final String name;
  final DateTime dueOn;
  final double progress;
  final List<Task> tasks;
  final List<Member> members;

  Project({
    this.id = '0',
    required this.name,
    required this.progress,
    required this.dueOn,
    required this.tasks,
    required this.members,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    List<Member> members = [];
    if (json['members'] != null) {
      for (var member in json['members']) {
        members.add(Member.fromJson(member));
      }
    }

    List<Task> tasks = [];
    if (json['tasks'] != null) {
      for (var task in json['tasks']) {
        tasks.add(Task.fromJson(task));
      }
    }

    return Project(
      id: json['id'],
      name: json['name'],
      progress: json['progress'],
      dueOn: json['dueOn'],
      tasks: tasks,
      members: members,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'progress': progress,
      'dueOn': dueOn,
      'tasks': tasks.map((task) => task.toJson()),
      'members': members.map((member) => member.toJson()),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
