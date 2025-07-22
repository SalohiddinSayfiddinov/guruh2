import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/firebase_features/cubit/f_auth_state.dart';
import 'package:guruh2/firebase_features/data/auth_service.dart';

class FAuthCubit extends Cubit<FAuthState> {
  FAuthCubit() : super(FAuthInitial());

  Future<void> signUp(String email, String password) async {
    emit(FAuthLoading());
    try {
      final user = await AuthService().signUp(email, password);
      if (user != null) {
        emit(FAuthSuccess(user));
      } else {
        emit(FAuthFailure('User is null'));
      }
    } catch (e) {
      emit(FAuthFailure('$e'));
    }
  }
}
