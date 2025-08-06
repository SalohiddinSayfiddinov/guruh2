import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guruh2/firebase_features/data/model/user_model.dart';
import 'package:guruh2/firebase_features/data/user_data_source.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final UserDataSource _datasource = UserDataSource();

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCred = await _auth.signInWithEmailAndPassword(
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

  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCred.user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  AuthService() {
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  /// Always check Google sign in initialization before use
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<User?> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    try {
      final account =
          await _googleSignIn.authenticate(scopeHint: ['email', 'profile']);
      final authorization = await account.authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await _datasource.createUser(UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? 'Google User',
        ));
      }

      return userCredential.user;
    } on GoogleSignInException catch (e) {
      print('Google Sign-In error: ${e.code.name}, ${e.description}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }
}
