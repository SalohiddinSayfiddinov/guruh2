part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PlanetModel> planets;
  final List<PlanetModel> favorites;
  final String? loadingPlanetId;

  HomeLoaded({
    required this.planets,
    required this.favorites,
    this.loadingPlanetId,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
