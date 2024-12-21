// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../data/models/review_model.dart';
import 'rating_stars.dart';

class ReviewCard extends StatefulWidget {
  final ReviewModel review;
  final Function(int rating, String comment)? onEdit;
  final VoidCallback? onDelete;
  final Function(int)? onUpvote;
  final Function(int)? onDownvote;

  const ReviewCard({
    Key? key,
    required this.review,
    this.onEdit,
    this.onDelete,
    this.onUpvote,
    this.onDownvote,
  }) : super(key: key);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _isEditing = false;
  late TextEditingController _commentController;
  late int _editedRating;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.review.comment);
    _editedRating = widget.review.rating;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

    void _handleSave() {
      if (_editedRating == 0 || _commentController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide both rating and comment')),
        );
        return;
      }
      
      // Pass the edited values
      widget.onEdit?.call(_editedRating, _commentController.text.trim());
      
      setState(() {
        _isEditing = false;
      });
    }

  void _handleCancel() {
    // Reset the edited values to original
    setState(() {
      _commentController.text = widget.review.comment;
      _editedRating = widget.review.rating;
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  child: Text(
                    widget.review.user[0].toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.user,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    _isEditing
                        ? RatingStars(
                            rating: _editedRating,
                            size: 24,
                            interactive: true,
                            onRatingChanged: (rating) {
                              setState(() {
                                _editedRating = rating;
                              });
                            },
                          )
                        : RatingStars(
                            rating: widget.review.rating,
                            size: 24,
                          ),
                  ],
                ),
              ],
            ),
            if (widget.review.isAuthor)
              Row(
                children: [
                  if (_isEditing) ...[
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: _handleSave,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _handleCancel,
                    ),
                  ] else ...[
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: widget.onDelete,
                    ),
                  ],
                ],
              ),
          ],
        ),
        const SizedBox(height: 12),
        _isEditing
            ? TextField(
                controller: _commentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Write your review...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            : Text(
                widget.review.comment,
                style: const TextStyle(color: Colors.grey),
              ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildVoteButton(
              icon: Icons.arrow_upward,
              count: widget.review.upvotes,
              onPressed: () => widget.onUpvote?.call(widget.review.id),
            ),
            const SizedBox(width: 12),
            _buildVoteButton(
              icon: Icons.arrow_downward,
              count: widget.review.downvotes,
              onPressed: () => widget.onDownvote?.call(widget.review.id),
            ),
          ],
        ),
        const Divider(height: 24),
      ],
    );
  }

  Widget _buildVoteButton({
    required IconData icon,
    required int count,
    required VoidCallback onPressed,
  }) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.grey),
          onPressed: onPressed,
        ),
        Text('$count', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}