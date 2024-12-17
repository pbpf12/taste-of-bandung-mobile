import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class BookmarkButton extends StatefulWidget {
  final bool isBookmarked;
  final int bookmarkCount;
  final Function(bool) onBookmarkToggle;

  const BookmarkButton({
    Key? key,
    required this.isBookmarked,
    required this.bookmarkCount,
    required this.onBookmarkToggle,
  }) : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  late bool _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isBookmarked = !_isBookmarked;
              widget.onBookmarkToggle(_isBookmarked);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _isBookmarked 
                  ? AppColors.primary 
                  : AppColors.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: _isBookmarked 
                      ? AppColors.text 
                      : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  _isBookmarked ? 'Remove Bookmark' : 'Bookmark Dish',
                  style: TextStyle(
                    color: _isBookmarked 
                        ? AppColors.text 
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '${widget.bookmarkCount} people bookmarked this dish',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}