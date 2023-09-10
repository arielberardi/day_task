import 'package:day_task/models/member_model.dart';

class Task {
  late String id;
  final String name;
  final double progress;
  final List<Member> members;

  Task({
    this.id = '0',
    required this.name,
    required this.progress,
    required this.members,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    List<Member> members = [];
    if (json['members'] != null) {
      for (var member in json['members']) {
        members.add(Member.fromJson(member));
      }
    }

    return Task(
      id: json['id'],
      name: json['name'],
      progress: json['progress'],
      members: members,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'progress': progress,
      'members': members.map((member) => member.toJson()),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
