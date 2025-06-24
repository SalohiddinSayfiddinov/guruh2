import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/presentation/auth/data/repository/auth_repo.dart';
import 'package:guruh2/presentation/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInit());

  Future<void> signUp(String email, String password) async {
    emit(const AuthLoading());
    try {
      final response = await AuthRepo().signUp(email, password);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verify(String email, String otp) async {
    emit(const AuthLoading());
    try {
      final result = await AuthRepo().verify(email, otp);
      emit(AuthSuccess(result));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
