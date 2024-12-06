import '../model/task.dart';

abstract class Storage {
  Future<List<Task>> getTasks();

  Future<Task> insertTask(String description);

  Future<void> removeTask(Task task);
}
