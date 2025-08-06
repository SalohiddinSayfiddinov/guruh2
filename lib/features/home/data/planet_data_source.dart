import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guruh2/features/home/data/planet_model.dart';

class PlanetDataSource {
  final CollectionReference _planets =
      FirebaseFirestore.instance.collection('planets');

  Future<List<PlanetModel>> fetchPlanets() async {
    try {
      final QuerySnapshot snapshot = await _planets.get();
      final List<PlanetModel> planets = snapshot.docs.map(
        (e) {
          final Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          data['id'] = e.id;
          return PlanetModel.fromMap(data);
        },
      ).toList();
      return planets;
    } catch (e) {
      throw Exception('Failed to fetch planets: $e');
    }
  }
}
