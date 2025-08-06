part of 'planet_cubit.dart';

abstract class PlanetState {}

class PlanetInitial extends PlanetState {}

class PlanetLoading extends PlanetState {}

class PlanetLoaded extends PlanetState {
  final List<PlanetModel> planets;

  PlanetLoaded({required this.planets});
}

class PlanetError extends PlanetState {
  final String message;

  PlanetError(this.message);
}
