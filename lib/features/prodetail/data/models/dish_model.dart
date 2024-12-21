// lib/data/models/dish_model.dart

class DishModel {
  final int id;
  final String name;
  final String description;
  final double price;  // Changed from dynamic to double
  final String? image;
  final int restaurantId;
  final String restaurantName;
  double averageRating;  // Changed from dynamic to double
  int bookmarkCount;
  bool isBookmarked;

  DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.image,
    required this.restaurantId,
    required this.restaurantName,
    required this.averageRating,
    required this.bookmarkCount,
    required this.isBookmarked,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      // Convert price string to double
      price: double.parse(json['price'].toString()),
      image: json['image'],
      restaurantId: json['restaurant_id'],
      restaurantName: json['restaurant_name'],
      // Convert average_rating to double, default to 0.0 if null
      averageRating: json['average_rating'] != null 
          ? double.parse(json['average_rating'].toString())
          : 0.0,
      bookmarkCount: json['bookmark_count'] ?? 0,
      isBookmarked: json['is_bookmarked'] ?? false,
    );
  }
}