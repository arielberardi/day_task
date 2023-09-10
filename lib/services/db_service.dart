import 'package:day_task/models/member_model.dart';
import 'package:day_task/models/project_model.dart';
import 'package:day_task/models/task_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  late FirebaseFirestore _database;

  DbService({FirebaseFirestore? instance}) {
    _database = instance ?? FirebaseFirestore.instance;
  }

  Future<String> createMember(Member member) async {
    final docRef = _database.collection('members').doc();
    await docRef.set(member.toJson());

    return docRef.id;
  }

  Future<Member> readMember(String id) async {
    final docRef = _database.collection('members').doc(id);
    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      return Future.error('database.errors.notFound'.tr(args: ['Member']));
    }

    return Member.fromJson(snapshot.data()!);
  }

  Future updateMember(String id, Member member) async {
    final docRef = _database.collection('members').doc(id);
    await docRef.update(member.toJson());
  }

  Future deleteMember(String id) async {
    await _database.collection('members').doc(id).delete();
  }

  Future<List<Member>> getAllMembers() async {
    final snapshot = await _database.collection('members').get();

    if (snapshot.size == 0) {
      return Future.error('database.errors.notFound'.tr(args: ['Members']));
    }

    return snapshot.docs
        .map((DocumentSnapshot doc) =>
            Member.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<String> createTask(Task task) async {
    final docRef = _database.collection('tasks').doc();

    await docRef.set(task.toJson());

    return docRef.id;
  }

  Future<Task> readTask(String id) async {
    final taskRef = await _database.collection('tasks').doc(id).get();
    if (!taskRef.exists) {
      return Future.error('database.errors.notFound'.tr(args: ['Task']));
    }

    Map<String, dynamic> data = taskRef.data()!;

    return Task.fromJson({
      'id': id,
      'name': data['name'],
      'progress': data['progress'].toDouble(),
      'members': data['members'],
    });
  }

  Future updateTask(String id, Task task) async {
    final docRef = _database.collection('tasks').doc(id);
    await docRef.update(task.toJson());
  }

  Future deleteTask(String id) async {
    await _database.collection('tasks').doc(id).delete();
  }

  Future<List<Task>> getAllTasks() async {
    final snapshot = await _database.collection('tasks').get();

    if (snapshot.size == 0) {
      return Future.error('database.errors.notFound'.tr(args: ['Tasks']));
    }

    return snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;

      return Task.fromJson({
        'id': doc.id,
        'name': data['name'],
        'progress': data['progress'].toDouble(),
        'members': data['members'],
      });
    }).toList();
  }

  Future<String> createProject(Project project) async {
    final docRef = _database.collection('projects').doc();

    await docRef.set(project.toJson());

    return docRef.id;
  }

  Future<Project> readProject(String id) async {
    final docRef = await _database.collection('projects').doc(id).get();
    if (!docRef.exists) {
      return Future.error('database.errors.notFound'.tr(args: ['Project']));
    }

    Map<String, dynamic> data = docRef.data()!;

    return Project.fromJson({
      'id': id,
      'name': data['name'],
      'progress': data['progress'].toDouble(),
      'dueOn': data['dueOn'].toDate(),
      'tasks': data['tasks'],
      'members': data['members'],
    });
  }

  Future updateProject(String id, Project project) async {
    final docRef = _database.collection('projects').doc(id);
    await docRef.update(project.toJson());
  }

  Future deleteProject(String id) async {
    await _database.collection('projects').doc(id).delete();
  }

  Future<List<Project>> getAllProjects() async {
    final snapshot = await _database.collection('projects').get();

    if (snapshot.size == 0) {
      return Future.error('database.errors.notFound'.tr(args: ['Projects']));
    }

    return snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;

      return Project.fromJson({
        'id': doc.id,
        'name': data['name'],
        'progress': data['progress'].toDouble(),
        'dueOn': data['dueOn'].toDate(),
        'tasks': data['tasks'],
        'members': data['members'],
      });
    }).toList();
  }
}
