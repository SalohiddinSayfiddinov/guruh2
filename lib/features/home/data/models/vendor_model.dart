class VendorModel {
  final int id;
  final String name;
  final String logo;
  final double rating;
  final int category;

  const VendorModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.category,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      rating: json['rating'] ?? 0.0,
      category: json['category'] ?? -1,
    );
  }
}
