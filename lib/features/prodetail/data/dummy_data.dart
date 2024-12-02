import 'models/dish_model.dart';
import 'models/restaurant_model.dart';
import 'models/review_model.dart';

class DummyData {
  static RestaurantModel getDummyRestaurant() {
    return RestaurantModel(
      id: 1,
      name: 'Delicious Eats',
      description: 'A cozy restaurant serving amazing dishes',
      image: 'https://example.com/restaurant.jpg',
      address: '123 Food Street, City',
      phone: '+1 (123) 456-7890',
      openingHours: '11:00 AM - 10:00 PM',
      priceRange: '\$\$',
    );
  }

  static DishModel getDummyDish() {
    return DishModel(
      id: 1,
      name: 'Gourmet Burger',
      description: 'A delicious burger made with premium ingredients',
      image: 'https://example.com/burger.jpg',
      price: 12.99,
      averageRating: 4.5,
      bookmarkCount: 256,
      isBookmarked: false,
      restaurant: getDummyRestaurant(),
    );
  }

  static List<ReviewModel> getDummyReviews() {
    return [
      ReviewModel(
        id: 1,
        user: 'John Doe',
        rating: 5,
        comment: 'Amazing dish! Loved every bite.',
        upvotes: 10,
        downvotes: 2,
        isAuthor: false,
      ),
      // Add more dummy reviews
    ];
  }
}