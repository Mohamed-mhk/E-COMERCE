import 'package:flutter/material.dart';

class CategoriesRail extends StatelessWidget {
  const CategoriesRail({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Engine', 'icon': Icons.settings_suggest_outlined},
      {'name': 'Brakes', 'icon': Icons.motion_photos_on_outlined},
      {'name': 'Tires', 'icon': Icons.radio_button_unchecked},
      {'name': 'Oil', 'icon': Icons.opacity},
      {'name': 'Battery', 'icon': Icons.battery_charging_full},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Categories',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 90, // Height for icon + text
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
