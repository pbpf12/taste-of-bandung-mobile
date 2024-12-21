// lib/features/prodetail/data/api_service.dart

import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'models/dish_model.dart';
import 'models/review_model.dart';
import 'models/restaurant_model.dart';
import '../../../core/environments/_environments.dart';

class ApiService {
  final String baseUrl = "http://${EndPoints().myBaseUrl}/api";

  /// Fetches dish details along with associated reviews.
  Future<DishDetail> fetchDishDetail(int dishId, CookieRequest request) async {
    final response = await request.get("$baseUrl/dishes/$dishId/");

    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to fetch dish details.');
    }

    return DishDetail.fromJson(response);
  }

  /// Toggles the bookmark status of a dish.
  Future<BookmarkResponse> bookmarkDish(int dishId, CookieRequest request) async {
    final response = await request.post("$baseUrl/dishes/$dishId/bookmark/", {});

    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to toggle bookmark.');
    }

    return BookmarkResponse.fromJson(response);
  }
  Future<ReviewModel> submitReview(
    int dishId,
    int rating,
    String comment,
    CookieRequest request,
  ) async {
    try {
      // Change this line - send as form data instead of JSON
      final response = await request.post(
        '$baseUrl/dishes/$dishId/reviews/',
        {
          'rating': rating.toString(), // Convert to string
          'comment': comment,
        },
      );

      if (response['status'] != 'success') {
        throw Exception(response['message'] ?? 'Failed to submit review');
      }

      return ReviewModel.fromJson(response['review']);
    } catch (e) {
      throw Exception('Failed to submit review: $e');
    }
  }

  Future<ReviewModel> editReview(
    int reviewId,
    int rating,
    String comment,
    CookieRequest request,
  ) async {
    try {
      final response = await request.post(
        "$baseUrl/reviews/$reviewId/edit/",
        {
          'rating': rating.toString(), // Convert to string
          'comment': comment,
        },
      );

      if (response['status'] != 'success') {
        throw Exception(response['message'] ?? 'Failed to edit review');
      }

      return ReviewModel.fromJson(response['review']);
    } catch (e) {
      throw Exception('Failed to edit review: $e');
    }
  }

  /// Deletes a review.
  Future<void> deleteReview(int reviewId, CookieRequest request) async {
    final response = await request.post("$baseUrl/reviews/$reviewId/delete/", {});

    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to delete review.');
    }
  }

  Future<VoteResponse> voteReview(
    int reviewId,
    String voteType,
    CookieRequest request,
  ) async {
    try {
      final response = await request.post(
        "$baseUrl/reviews/$reviewId/vote/$voteType/",
        jsonEncode({}),
      );

      if (response['status'] != 'success') {
        throw Exception(response['message'] ?? 'Failed to vote on review');
      }

      return VoteResponse.fromJson(response);
    } catch (e) {
      throw Exception('Failed to vote on review: $e');
    }
  }

  /// Fetches details of a restaurant.
  Future<RestaurantDetail> fetchRestaurantDetail(int restaurantId, CookieRequest request) async {
    final response = await request.get("$baseUrl/restaurants/$restaurantId/");

    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to fetch restaurant details.');
    }

    return RestaurantDetail.fromJson(response);
  }

  /// Searches for dishes based on a query.
  Future<List<DishModel>> searchDishes(String query, CookieRequest request) async {
    final response = await request.get("$baseUrl/dishes/?search=$query");

    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to search dishes.');
    }

    return List<DishModel>.from(
      response['dishes'].map((x) => DishModel.fromJson(x)),
    );
  }
}

// Define response models as needed

class DishDetail {
  final DishModel dish;
  final List<ReviewModel> reviews;

  DishDetail({required this.dish, required this.reviews});

  factory DishDetail.fromJson(Map<String, dynamic> json) {
    return DishDetail(
      dish: DishModel.fromJson(json['dish']),
      reviews: List<ReviewModel>.from(json['reviews'].map((x) => ReviewModel.fromJson(x))),
    );
  }
}

class BookmarkResponse {
  final bool isBookmarked;
  final int bookmarkCount;
  final String message;

  BookmarkResponse({required this.isBookmarked, required this.bookmarkCount, required this.message});

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkResponse(
      isBookmarked: json['is_bookmarked'],
      bookmarkCount: json['bookmark_count'],
      message: json['message'],
    );
  }
}

class VoteResponse {
  final int upvotes;
  final int downvotes;

  VoteResponse({required this.upvotes, required this.downvotes});

  factory VoteResponse.fromJson(Map<String, dynamic> json) {
    return VoteResponse(
      upvotes: json['upvotes'],
      downvotes: json['downvotes'],
    );
  }
}

class RestaurantDetail {
  final RestaurantModel restaurant;

  RestaurantDetail({required this.restaurant});

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      restaurant: RestaurantModel.fromJson(json['restaurant']),
    );
  }
}
