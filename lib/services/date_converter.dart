import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? toDateTime(dynamic data) {
  if (data == null || data is! Timestamp) {
    return null;
  }
  final Timestamp ts = data;
  return DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
}
