import 'package:flutter/material.dart';
import 'package:guruh2/firebase_features/data/auth_service.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Center(
          child: SizedBox(
            height: 50.0,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                AuthService().signInWithGoogle();
              },
              child: const Text('Google Sign in'),
            ),
          ),
        ),
      ),
    );
  }
}
