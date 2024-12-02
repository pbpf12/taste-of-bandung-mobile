class RestaurantModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String address;
  final String phone;
  final String openingHours;
  final String priceRange;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.address,
    required this.phone,
    required this.openingHours,
    required this.priceRange,
  });
}