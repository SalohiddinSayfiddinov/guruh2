import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guruh2/firebase_features/data/model/user_model.dart';

class UserDataSource {
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      await _user.doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
