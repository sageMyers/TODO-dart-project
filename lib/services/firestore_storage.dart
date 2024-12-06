import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/services/storage.dart';

class FirestoreStorage implements Storage {
  static const _tasks = 'tasks';
  static const _description = 'description';

  @override
  Future<List<Task>> getTasks() async {
    final snapshot = await FirebaseFirestore.instance.collection(_tasks).get();
    final tasks = snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();
    return tasks as List<Task>;
  }

  @override
  Future<Task> insertTask(String description) async {
    return Task(id: '-1');
  }

  @override
  Future<void> removeTask(Task task) {
    return Future.value();
  }
}
