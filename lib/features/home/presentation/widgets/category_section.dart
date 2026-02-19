import 'package:ecomerce/core/app_theme.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Categories
    final categories = [
      {'name': 'Tires', 'icon': Icons.tire_repair},
      {'name': 'Brakes', 'icon': Icons.settings},
      {'name': 'Engine', 'icon': Icons.engineering},
      {'name': 'Batteries', 'icon': Icons.battery_charging_full},
      {'name': 'Lights', 'icon': Icons.lightbulb},
      {'name': 'Interior', 'icon': Icons.chair},
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                  child: Icon(
                    category['icon'] as IconData,
                    size: 28,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category['name'] as String,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
