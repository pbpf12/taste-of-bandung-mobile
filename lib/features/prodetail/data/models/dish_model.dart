import 'restaurant_model.dart';
class DishModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final double averageRating;
  final int bookmarkCount;
  final bool isBookmarked;
  final RestaurantModel restaurant;

  DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.averageRating,
    required this.bookmarkCount,
    required this.isBookmarked,
    required this.restaurant,
  });
}