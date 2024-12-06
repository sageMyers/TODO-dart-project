import '../model/task.dart';
import '../services/firestore_storage.dart';

class TaskController {
  factory TaskController() => _singleton;

  TaskController._internal();

  static final TaskController _singleton = TaskController._internal();

  Future<List<Task>> getTasks() async {
    return Future.value(await FirestoreStorage().getTasks());
  }
}
