import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/data/planet_data_source.dart';
import 'package:guruh2/features/home/data/planet_model.dart';

part 'planet_state.dart';

class PlanetCubit extends Cubit<PlanetState> {
  PlanetCubit() : super(PlanetInitial());

  void getPlanets() async {
    emit(PlanetLoading());
    try {
      final planets = await PlanetDataSource().fetchPlanets();
      emit(PlanetLoaded(planets: planets));
    } catch (e) {
      emit(PlanetError('Failed to load planets: $e'));
    }
  }
}
