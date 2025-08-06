import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/data/planet_data_source.dart';
import 'package:guruh2/features/home/data/planet_model.dart';
import 'package:guruh2/firebase_features/data/user_data_source.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PlanetDataSource _planetDataSource = PlanetDataSource();
  final UserDataSource _userDataSource = UserDataSource();

  HomeCubit() : super(HomeInitial());

  Future<void> loadHomeData(String userId) async {
    emit(HomeLoading());
    try {
      final planets = await _planetDataSource.fetchPlanets();
      final favorites = await _userDataSource.getFavs(userId);
      emit(HomeLoaded(planets: planets, favorites: favorites));
    } catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }

  Future<void> toggleFavorite(String userId, PlanetModel planet) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(HomeLoaded(
        planets: currentState.planets,
        favorites: currentState.favorites,
        loadingPlanetId: planet.id,
      ));
      try {
        await _userDataSource.addPlanetToFavs(userId, planet);
        final newFavs = await _userDataSource.getFavs(userId);
        emit(HomeLoaded(
          planets: currentState.planets,
          favorites: newFavs,
        ));
      } catch (e) {
        emit(HomeError('Failed to update favorites: $e'));
      }
    }
  }
}
