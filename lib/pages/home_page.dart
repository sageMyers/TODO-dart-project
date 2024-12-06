import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/pages/new_task_page.dart';
import '/services/local_storage.dart';
import '../controllers/task_controller.dart';
import '../model/task.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Task>>? _tasksFuture;
  List<Task>? _tasks;
  bool _hasCompletedTask = false;

  @override
  void initState() {
    super.initState();
    //fetchData();
    _tasksFuture = TaskController().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        if (_tasks == null &&
            snapshot.connectionState == ConnectionState.done) {
          _tasks = snapshot.data;
        }
        if (_tasks == null &&
            snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Todo')),
            body: const CircularProgressIndicator(),
          );
        } else if (_tasks == null && snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Todo')),
            body: const Text('Error loading tasks'),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Todo'),
              actions: _hasCompletedTask
                  ? [
                      IconButton(
                        onPressed: () {
                          _deleteCompletedTasks();
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ]
                  : [],
            ),
            body: ListView.separated(
              itemBuilder: (_, index) => _toWidget(index),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _tasks!.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _addNewTask,
              child: const Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  Widget _toWidget(int index) {
    var t = _tasks![index];
    return Center(
        child: Column(children: <Widget>[
      const SizedBox(
        height: 30,
      ),
      CheckboxListTile(
        title: Text(t.description),
        value: t.isCompleted,
        onChanged: (value) => _onTaskChanged(t, value ?? false),
      )
    ]));
  }

  void _addNewTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewTaskPage()),
    );
    if (result != null && result.isNotEmpty) {
      setState(() {
        final newTask = Task(description: result);
        _tasks!.add(newTask);
        _updateCompletedTaskStatus();
        LocalStorage().insertTask(result);
      });
    }
  }

  void _onTaskChanged(Task task, bool newValue) {
    setState(() {
      task.isCompleted = newValue;
      _updateCompletedTaskStatus();
    });
  }

  void _updateCompletedTaskStatus() {
    setState(() {
      _hasCompletedTask = _tasks!.any((task) => task.isCompleted);
    });
  }

  void _deleteCompletedTasks() {
    _updateCompletedTaskStatus();
    setState(() {
      for (var task in _tasks!) {
        if (task.isCompleted) {
          LocalStorage().removeTask(task);
        }
      }
      _tasks!.removeWhere((task) => task.isCompleted);
    });
  }

  void fetchData() {
    FirebaseFirestore.instance
        .collection('your_collection')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
      });
    });
  }
}
