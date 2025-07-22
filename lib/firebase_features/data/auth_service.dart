import 'package:firebase_auth/firebase_auth.dart';
import 'package:guruh2/firebase_features/data/model/user_model.dart';
import 'package:guruh2/firebase_features/data/user_data_source.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final UserDataSource _datasource = UserDataSource();

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCred =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCred.user != null) {
        _datasource.createUser(
          UserModel(
            id: userCred.user!.uid,
            email: email,
            name: 'John',
          ),
        );
        return userCred.user;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
