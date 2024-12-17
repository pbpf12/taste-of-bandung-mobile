// lib/data/models/dish_model.dart

class DishModel {
  int id;
  String name;
  String description;
  String price;
  String? category;
  int restaurantId;
  String restaurantName;
  double averageRating; // Made mutable
  int bookmarkCount; // Made mutable
  bool isBookmarked; // Made mutable
  String? image;

  DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.category,
    required this.restaurantId,
    required this.restaurantName,
    required this.averageRating,
    required this.bookmarkCount,
    required this.isBookmarked,
    this.image,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      restaurantId: json['restaurant_id'],
      restaurantName: json['restaurant_name'],
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      bookmarkCount: json['bookmark_count'],
      isBookmarked: json['is_bookmarked'],
      image: json['image'],
    );
  }
}
