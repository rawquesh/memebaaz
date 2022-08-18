import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Future<void> addLike(String id, bool increment) async =>
       FirebaseFirestore.instance.collection('content').doc(id).update({'likes': FieldValue.increment(increment ? 1 : -1)});
}
