import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guruh2/features/home/data/planet_model.dart';
import 'package:guruh2/firebase_features/data/model/user_model.dart';

class UserDataSource {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      await _users.doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final QuerySnapshot snapshot = await _users.get();
      final List<UserModel> users = snapshot.docs.map(
        (e) {
          final Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          data['id'] = e.id;
          return UserModel.fromMap(data);
        },
      ).toList();
      return users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<void> addPlanetToFavs(String userId, PlanetModel planet) async {
    try {
      final bool isLiked = await isPlanetLiked(userId, planet.id);
      if (isLiked) {
        await _users
            .doc(userId)
            .collection('favorites')
            .doc(planet.id)
            .delete();
      } else {
        await _users
            .doc(userId)
            .collection('favorites')
            .doc(planet.id)
            .set(planet.toMap());
      }
    } catch (e) {
      throw Exception('Failed to add planet to favorites: $e');
    }
  }

  Future<bool> isPlanetLiked(String userId, String planetId) async {
    final doc =
        await _users.doc(userId).collection('favorites').doc(planetId).get();
    return doc.exists;
  }

  Future<List<PlanetModel>> getFavs(String userId) async {
    try {
      final QuerySnapshot snapshot =
          await _users.doc(userId).collection('favorites').get();
      final List<PlanetModel> planets = snapshot.docs.map(
        (e) {
          final Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          data['id'] = e.id;
          return PlanetModel.fromMap(data);
        },
      ).toList();
      return planets;
    } catch (e) {
      throw Exception('Failed to fetch favorite planets: $e');
    }
  }
}
