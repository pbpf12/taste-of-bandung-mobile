class ReviewModel {
  final int id;
  final String user;
  final int rating;
  final String comment;
  final int upvotes;
  final int downvotes;
  final bool isAuthor;

  ReviewModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.comment,
    required this.upvotes,
    required this.downvotes,
    required this.isAuthor,
  });
}