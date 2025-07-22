import 'package:firebase_auth/firebase_auth.dart';

abstract class FAuthState {}

class FAuthInitial extends FAuthState {}

class FAuthLoading extends FAuthState {}

class FAuthSuccess extends FAuthState {
  final User user;

  FAuthSuccess(this.user);
}

class FAuthFailure extends FAuthState {
  final String error;

  FAuthFailure(this.error);
}
