import 'package:flutter/material.dart';
import 'presentation/themes/app_colors.dart';
import 'presentation/widgets/bookmark_button.dart';
import 'presentation/widgets/rating_stars.dart';
import 'presentation/widgets/review_card.dart';
import 'presentation/widgets/restaurant_modal.dart';
import 'data/dummy_data.dart';
import 'data/models/dish_model.dart';
import 'data/models/review_model.dart';

class ProdetailScreen extends StatefulWidget {
  const ProdetailScreen({
    required this.dihsId,
    super.key
  });

  final int dihsId;

  @override
  State<ProdetailScreen> createState() => _ProdetailScreenState();
}

class _ProdetailScreenState extends State<ProdetailScreen> {
  late DishModel _dish;
  late List<ReviewModel> _reviews;
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    // In a real app, you'd fetch the dish and reviews based on dishId
    _dish = DummyData.getDummyDish();
    _reviews = DummyData.getDummyReviews();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addReview() {
    if (_selectedRating > 0 && _commentController.text.isNotEmpty) {
      final newReview = ReviewModel(
        id: _reviews.length + 1,
        user: 'Current User', // In a real app, this would be the logged-in user
        rating: _selectedRating,
        comment: _commentController.text,
        upvotes: 0,
        downvotes: 0,
        isAuthor: true,
      );

      setState(() {
        _reviews.insert(0, newReview);
        _commentController.clear();
        _selectedRating = 0;
      });

      // Show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review added successfully')),
      );
    } else {
      // Show an error if rating or comment is missing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a rating and comment')),
      );
    }
  }

  void _editReview(ReviewModel review) {
    // In a real app, this would interact with a backend
    setState(() {
      final index = _reviews.indexWhere((r) => r.id == review.id);
      if (index != -1) {
        _reviews[index] = review;
      }
    });
  }

  void _deleteReview(int reviewId) {
    setState(() {
      _reviews.removeWhere((review) => review.id == reviewId);
    });
  }

  void _voteReview(int reviewId, bool isUpvote) {
    setState(() {
      final index = _reviews.indexWhere((review) => review.id == reviewId);
      if (index != -1) {
        final review = _reviews[index];
        _reviews[index] = ReviewModel(
          id: review.id,
          user: review.user,
          rating: review.rating,
          comment: review.comment,
          upvotes: isUpvote ? review.upvotes + 1 : review.upvotes,
          downvotes: !isUpvote ? review.downvotes + 1 : review.downvotes,
          isAuthor: review.isAuthor,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDishDetails(),
                  const SizedBox(height: 24),
                  _buildReviewSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          _dish.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDishDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _dish.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _dish.description,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${_dish.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            RatingStars(rating: _dish.averageRating.round()),
          ],
        ),
        const SizedBox(height: 16),
        BookmarkButton(
          isBookmarked: _dish.isBookmarked,
          bookmarkCount: _dish.bookmarkCount,
          onBookmarkToggle: (isBookmarked) {
            // Implement bookmark logic
          },
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => RestaurantModal(
                restaurant: _dish.restaurant,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.text,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text('View ${_dish.restaurant.name} Details'),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Reviews',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 16),
        _buildAddReviewSection(),
        const SizedBox(height: 16),
        ..._reviews.map((review) => ReviewCard(
              review: review,
              onEdit: () => _editReview(review),
              onDelete: () => _deleteReview(review.id),
              onUpvote: (id) => _voteReview(id, true),
              onDownvote: (id) => _voteReview(id, false),
            )),
      ],
    );
  }

  Widget _buildAddReviewSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Your Review',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 12),
            RatingStars(
              rating: _selectedRating,
              interactive: true,
              onRatingChanged: (rating) {
                setState(() {
                  _selectedRating = rating;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Write your review here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.text,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}