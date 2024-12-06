import '../model/task.dart';

class FakeData {
  factory FakeData() => _singleton;
  var isCompleted = false;
  FakeData._internal();

  static final FakeData _singleton = FakeData._internal();



  List<Task> getTasks() {
    return [
      Task(description: 'Task 1'),
      Task(description: 'Task 2'),
      Task(
          description:
              'This is a longer task that requires you to wrap the text to a new line and to make sure that the visuals handle that correctly.'),
      Task(description: 'Task 4'),
    ];
  }
}
