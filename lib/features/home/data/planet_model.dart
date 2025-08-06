class PlanetModel {
  final String id;
  final String name;
  final String bio;
  final String description;
  final String image;
  final double day;
  final double distanceFromSun;
  final double gravity;
  final double mass;
  final double meanTemp;
  final double velocity;

  PlanetModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.description,
    required this.image,
    required this.day,
    required this.distanceFromSun,
    required this.gravity,
    required this.mass,
    required this.meanTemp,
    required this.velocity,
  });

  factory PlanetModel.fromMap(Map<String, dynamic> map) {
    return PlanetModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      day: (map['day'] as num?)?.toDouble() ?? 0.0,
      distanceFromSun: (map['distanceFromSun'] as num?)?.toDouble() ?? 0.0,
      gravity: (map['gravity'] as num?)?.toDouble() ?? 0.0,
      mass: (map['mass'] as num?)?.toDouble() ?? 0.0,
      meanTemp: (map['meanTemp'] as num?)?.toDouble() ?? 0.0,
      velocity: (map['velocity'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'description': description,
      'image': image,
      'day': day,
      'distanceFromSun': distanceFromSun,
      'gravity': gravity,
      'mass': mass,
      'meanTemp': meanTemp,
      'velocity': velocity,
    };
  }
}
