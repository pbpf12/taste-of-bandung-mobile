import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../data/models/restaurant_model.dart';

class RestaurantModal extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantModal({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant.image ?? '',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Name and Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                restaurant.description,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // Details
              _buildDetailRow(
                icon: Icons.location_on,
                text: restaurant.address,
              ),
              _buildDetailRow(
                icon: Icons.phone,
                text: restaurant.phone,
              ),
              _buildDetailRow(
                icon: Icons.access_time,
                text: restaurant.openingHours,
              ),
              _buildDetailRow(
                icon: Icons.attach_money,
                text: restaurant.priceRange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.grey),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
