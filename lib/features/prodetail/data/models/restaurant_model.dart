
// lib/data/models/restaurant_model.dart

class RestaurantModel {
  final int id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String openingHours;
  final String? image;
  final String priceRange;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.openingHours,
    this.image,
    required this.priceRange,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      openingHours: json['opening_hours'],
      image: json['image'],
      priceRange: json['price_range'],
    );
  }
}
