// lib/features/prodetail/presentation/screens/prodetail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'data/api_service.dart';
import 'data/models/dish_model.dart';
import 'data/models/review_model.dart';
import 'data/models/restaurant_model.dart';
import 'widgets/bookmark_button.dart';
import 'widgets/rating_stars.dart' as stars;
import 'widgets/restaurant_modal.dart' as modal;
import 'widgets/review_card.dart';
import 'themes/app_colors.dart';

class ProdetailScreen extends StatefulWidget {
  const ProdetailScreen({
    required this.dishId,
    super.key,
  });

  final int dishId;

  @override
  State<ProdetailScreen> createState() => _ProdetailScreenState();
}

class _ProdetailScreenState extends State<ProdetailScreen> {
  late int dishId;
  final ApiService _apiService = ApiService();

  DishModel? _dish;
  List<ReviewModel> _reviews = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Controllers for submitting a new review
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    dishId = widget.dishId;
    _fetchDishDetails();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  /// Fetches dish details and associated reviews from the backend.
  Future<void> _fetchDishDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Retrieve CookieRequest from Provider
      final request = context.read<CookieRequest>();

      // Fetch dish details using ApiService and CookieRequest
      final dishDetail = await _apiService.fetchDishDetail(dishId, request);
      if (!mounted) return;

      setState(() {
        _dish = dishDetail.dish;
        _reviews = dishDetail.reviews;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  /// Toggles the bookmark status of the dish.
  Future<void> _toggleBookmark(bool isBookmarked) async {
    if (_dish == null) return;

    try {
      final request = context.read<CookieRequest>();

      final bookmarkResponse = await _apiService.bookmarkDish(dishId, request);
      if (!mounted) return;

      setState(() {
        _dish!.isBookmarked = bookmarkResponse.isBookmarked;
        _dish!.bookmarkCount = bookmarkResponse.bookmarkCount;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(bookmarkResponse.message)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to toggle bookmark: $e')),
      );
    }
  }

  /// Submits a new review for the dish.
  Future<void> _submitReview() async {
    if (_selectedRating == 0 || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide both rating and comment')),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);
      final request = context.read<CookieRequest>();
      
      final newReview = await _apiService.submitReview(
        dishId,
        _selectedRating,
        _commentController.text.trim(),
        request,
      );

      if (!mounted) return;

      setState(() {
        _reviews.insert(0, newReview);
        _calculateAndSetAverageRating();
        _selectedRating = 0;
        _commentController.clear();
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $e')),
      );
    }
  }

  /// Edits an existing review.
  Future<void> _editReview(int reviewId, int newRating, String newComment) async {
    try {
      final request = context.read<CookieRequest>();

      final updatedReview = await _apiService.editReview(
        reviewId,
        newRating,
        newComment,
        request,
      );

      if (!mounted) return;

      setState(() {
        int index = _reviews.indexWhere((review) => review.id == reviewId);
        if (index != -1) {
          _reviews[index] = updatedReview;
          _calculateAndSetAverageRating();
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review updated successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update review: $e')),
      );
    }
  }

  /// Deletes a review.
  Future<void> _deleteReview(int reviewId) async {
    try {
      final request = context.read<CookieRequest>();

      await _apiService.deleteReview(reviewId, request);
      if (!mounted) return;

      setState(() {
        _reviews.removeWhere((review) => review.id == reviewId);
        _calculateAndSetAverageRating();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review deleted successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete review: $e')),
      );
    }
  }

  /// Votes on a review (upvote or downvote).
  Future<void> _voteReview(int reviewId, String voteType) async {
    try {
      final request = context.read<CookieRequest>();

      final voteResponse = await _apiService.voteReview(reviewId, voteType, request);
      if (!mounted) return;

      setState(() {
        int index = _reviews.indexWhere((review) => review.id == reviewId);
        if (index != -1) {
          _reviews[index].upvotes = voteResponse.upvotes;
          _reviews[index].downvotes = voteResponse.downvotes;
        }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to vote: $e')),
      );
    }
  }

  /// Displays the restaurant details in a modal dialog.
  Future<void> _showRestaurantDetails() async {
    if (_dish == null) return;

    try {
      final request = context.read<CookieRequest>();

      final restaurantDetail = await _apiService.fetchRestaurantDetail(
        _dish!.restaurantId,
        request,
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => modal.RestaurantModal(restaurant: restaurantDetail.restaurant),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load restaurant details: $e')),
      );
    }
  }

  /// Calculates and sets the average rating based on current reviews.
  void _calculateAndSetAverageRating() {
    if (_reviews.isEmpty) {
      _dish!.averageRating = 0.0;
      return;
    }
    double total = _reviews.fold(0.0, (sum, review) => sum + review.rating);
    _dish!.averageRating = total / _reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dish Details'),
      ),
      body: _isLoading
          ? const Center(
              child: SpinKitCircle(
                color: Colors.orange,
                size: 50.0,
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFB845),
                          Color(0xFFFFC966),
                          Color(0xFFFFD57A),
                          Color(0xFFFFE38E),
                          Color(0xFFFFF0A1),
                          Color(0xFFFFEB84),
                          Color(0xFFFFF7C2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dish Details Section
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Dish Image
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.network(
                                  (_dish!.image?.isNotEmpty ?? false)
                                      ? _dish!.image!
                                      : 'https://via.placeholder.com/400x250.png?text=No+Image',
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 250,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Dish Name
                                    Text(
                                      _dish!.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Dish Description
                                    Text(
                                      _dish!.description,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    // Price and Rating
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0x1AFFB845), // 10% opacity
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'Rp.${_dish!.price}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFFB845),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.star, color: Color(0xFF2C2C2C)),
                                              const SizedBox(width: 4),
                                              Text(
                                                _dish!.averageRating.toStringAsFixed(1),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF2C2C2C),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    // Bookmark Button
                                    BookmarkButton(
                                      isBookmarked: _dish!.isBookmarked,
                                      bookmarkCount: _dish!.bookmarkCount,
                                      onBookmarkToggle: _toggleBookmark,
                                    ),
                                    const SizedBox(height: 16),
                                    // View Restaurant Details Button
                                    ElevatedButton.icon(
                                      onPressed: _showRestaurantDetails,
                                      icon: const Icon(Icons.restaurant),
                                      label: Text('View ${_dish!.restaurantName}\'s Details'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.text,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Reviews Section
                        Text(
                          'Customer Reviews',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // List of Reviews
                        _reviews.isEmpty
                            ? const Text(
                                'No reviews yet. Be the first to review!',
                                style: TextStyle(color: Colors.grey),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _reviews.length,
                                itemBuilder: (context, index) {
                                  final review = _reviews[index];
                                  return ReviewCard(
                                    review: review,
                                    onEdit: (newRating, newComment) {
                                      _editReview(
                                        review.id, 
                                        newRating,
                                        newComment
                                      );
                                    },
                                    onDelete: () {
                                      _deleteReview(review.id);
                                    },
                                    onUpvote: (reviewId) {
                                      _voteReview(reviewId, 'upvote');
                                    },
                                    onDownvote: (reviewId) {
                                      _voteReview(reviewId, 'downvote');
                                    },
                                  );
                                },
                              ),
                        const SizedBox(height: 24),
                        // Submit Review Form
                        Text(
                          'Write a Review',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Rating Stars
                              const Text(
                                'Rating',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              stars.RatingStars(
                                rating: _selectedRating,
                                size: 32,
                                activeColor: AppColors.primary,
                                inactiveColor: Colors.grey[300]!,
                                interactive: true,
                                onRatingChanged: (rating) {
                                  setState(() {
                                    _selectedRating = rating;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              // Comment TextField
                              const Text(
                                'Comment',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _commentController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: 'Share your experience...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Submit Button
                              ElevatedButton(
                                onPressed: _submitReview,
                                child: const Text('Submit Review'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.text,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}