import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: ListView(
        children: [
          TextField(
            controller: _taskController,
            decoration: const InputDecoration(labelText: 'New task'),
            minLines: 3,
            maxLines: 3,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final result = _taskController.text;
              Navigator.pop(context, result);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

