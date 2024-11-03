class DishModel {
  final int id; 
  final String name; 
  final String restaurantName; 
  final String description; 
  final String price; 
  final String imageUrl; 
  final int bookMarkCount; 
  final double averageRating; 

  DishModel({
    this.id = 0, 
    this.name = "", 
    this.restaurantName = "", 
    this.description = "", 
    this.price = "0.00", 
    this.imageUrl = "", 
    this.bookMarkCount = 0, 
    this.averageRating = 0.0, 
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      restaurantName: json['restaurantName'] ?? "", 
      description: json['description'] ?? "", 
      price: json['price'] ?? "0.00",
      imageUrl: json['imageUrl'] ?? "",
      bookMarkCount: json['bookMarkCount'] ?? 0,
      averageRating: (json['averageRating'] ?? 0.0) as double,
    );
  }

  DishModel copyWith({
    int? id,
    String? name,
    String? restaurantName,
    String? description,
    String? price,
    String? imageUrl,
    int? bookMarkCount,
    double? averageRating,
  }) {
    return DishModel(
      id: id ?? this.id,
      name: name ?? this.name,
      restaurantName: restaurantName ?? this.restaurantName,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      bookMarkCount: bookMarkCount ?? this.bookMarkCount,
      averageRating: averageRating ?? this.averageRating,
    );
  }
}
