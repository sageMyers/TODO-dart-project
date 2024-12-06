import'package:uuid/uuid.dart';
class Task {
  Task({this.description = '', String? id})
      : isCompleted = false,
        id = id ?? _uuid.v1();
  bool isCompleted;
  static const _uuid = Uuid();
  final String description;
  final String id;

  static fromMap(Map<String, dynamic> data) {}
}
