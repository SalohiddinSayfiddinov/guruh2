import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/data/planet_model.dart';
import 'package:guruh2/firebase_features/data/model/user_model.dart';
import 'package:guruh2/firebase_features/data/user_data_source.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getUsers() async {
    emit(UserLoading());
    try {
      final users = await UserDataSource().getUsers();
      emit(UserLoaded(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> likePlanet(String userId, PlanetModel planet) async {
    emit(UserLoading());
    try {
      await UserDataSource().addPlanetToFavs(userId, planet);
      emit(UserLoaded(users: []));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> getFavs(String userId) async {
    emit(UserLoading());
    try {
      final favs = await UserDataSource().getFavs(userId);
      emit(UserFavsLoaded(planets: favs));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
