import 'package:cloud_firestore/cloud_firestore.dart';

class Streams {
  static const users = 'users';
  static const dress = 'clothes';

  final userQuery = FirebaseFirestore.instance.collection(users);
  final clothQuery = FirebaseFirestore.instance.collection(dress);
}
