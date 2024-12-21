// lib/data/models/review_model.dart

class ReviewModel {
  final int id;
  final String user;
  int upvotes; // Made mutable
  int downvotes; // Made mutable
  int rating;
  String comment;
  final bool isAuthor;

  ReviewModel({
    required this.id,
    required this.user,
    required this.upvotes,
    required this.downvotes,
    required this.rating,
    required this.comment,
    required this.isAuthor,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      user: json['user'],
      upvotes: json['upvotes'],
      downvotes: json['downvotes'],
      rating: json['rating'],
      comment: json['comment'],
      isAuthor: json['is_author'],
    );
  }
}
