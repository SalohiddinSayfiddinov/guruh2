import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guruh2/firebase_features/data/model/user_model.dart';

class UserDataSource {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      await _users.doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final QuerySnapshot snapshot = await _users.get();
      final List<UserModel> users = snapshot.docs.map(
        (e) {
          final Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          data['id'] = e.id;
          return UserModel.fromMap(data);
        },
      ).toList();
      return users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}

List<Map<String, dynamic>> users = [
  {
    'id': '1',
    'data': {
      'email': '',
      'name': '',
    },
  },
  {
    'id': '2',
    'data': {
      'email': '',
      'name': '',
    },
  }
];
