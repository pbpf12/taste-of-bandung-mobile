import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../../data/models/restaurant_model.dart';

class RestaurantModal extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantModal({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                restaurant.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              restaurant.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
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
    );
  }

  Widget _buildDetailRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}