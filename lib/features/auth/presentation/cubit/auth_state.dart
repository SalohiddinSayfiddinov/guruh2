abstract class AuthState {
  const AuthState();
}

class AuthInit extends AuthState {
  const AuthInit();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final String data;
  const AuthSuccess(this.data);
}

class AuthError extends AuthState {
  final String error;
  const AuthError(this.error);
}
