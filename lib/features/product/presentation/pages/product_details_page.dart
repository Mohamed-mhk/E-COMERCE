import 'package:flutter/material.dart';
import 'package:ecomerce/features/product/domain/entities/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final dynamic product;

  const ProductDetailsPage({super.key, required this.product});

  String get _name {
    if (product is Product) return (product as Product).name;
    return product['name'] ?? 'Product Name';
  }

  String get _description {
    if (product is Product) return (product as Product).description;
    return product['description'] ?? 'Engineered for low dust and noise, these premium ceramic brake pads provide superior stopping power and extended rotor life. Ideal for daily commuting and spirited driving.';
  }

  double get _price {
    if (product is Product) return (product as Product).price;
    return (product['price'] as num?)?.toDouble() ?? 0.0;
  }

  String get _imageUrl {
    if (product is Product) return (product as Product).imageUrl;
    return product['image'] ?? product['imageUrl'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // Space for bottom bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Hero Image Section
                ProductHeroSection(imageUrl: _imageUrl),
                
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. Title & Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              _name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${_price.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '\$${(_price * 1.3).toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[400],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // 3. Rating
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                size: 18,
                                color: index < 4 ? Colors.amber[400] : Colors.grey[300],
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '4.8',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(128 reviews)',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[500],
                                ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // 4. Compatibility Widget
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5), // emerald-50
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD1FAE5)), // emerald-100
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD1FAE5), // emerald-100
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check_circle, color: Color(0xFF059669)), // emerald-600
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Fits your vehicle',
                                    style: TextStyle(
                                      color: Color(0xFF065F46), // emerald-800
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '2018 Toyota Camry XSE V6',
                                    style: TextStyle(
                                      color: const Color(0xFF059669).withValues(alpha: 0.8),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Change',
                                style: TextStyle(
                                  color: Color(0xFF059669),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // 5. Specifications
                      Text(
                        'Specifications',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 3.5, // Wide, short cells
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 12,
                        children: const [
                          SpecItem(label: 'Material', value: 'Ceramic Composite'),
                          SpecItem(label: 'Fitment', value: 'Front Axle'),
                          SpecItem(label: 'Part Number', value: 'BP-9921-ZR'),
                          SpecItem(label: 'Warranty', value: '2 Year / 24k Miles'),
                          SpecItem(label: 'In Stock', value: 'Available at Store', valueColor: Colors.green),
                          SpecItem(label: 'Weight', value: '4.2 lbs'),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // 6. Description
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                              height: 1.6,
                            ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // 7. Often Bought Together
                      Text(
                        'Often Bought Together',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            AddOnCard(
                              name: 'DOT 4 Brake Fluid',
                              price: '\$8.99',
                              imageAsset: 'assets/images/motor_oil.png', // Existing asset
                            ),
                            SizedBox(width: 16),
                            AddOnCard(
                              name: 'Brake Cleaner Spray',
                              price: '\$5.49',
                              imageAsset: 'assets/images/motor_oil.png', // Existing asset
                            ),
                            SizedBox(width: 16),
                             AddOnCard(
                              name: 'Mechanic Gloves',
                              price: '\$12.99',
                              imageAsset: 'assets/images/air_filter.png', // Existing asset
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Header (Absolute)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleIconButton(
                      icon: Icons.arrow_back,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: [
                        CircleIconButton(
                          icon: Icons.favorite_border,
                          onPressed: () {},
                        ),
                        const SizedBox(width: 12),
                        CircleIconButton(
                          icon: Icons.ios_share,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
                border: Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    // Quantity Stepper
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 20, color: Colors.grey),
                            onPressed: () {},
                          ),
                          const Text(
                            '1',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 20, color: Colors.grey),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Add to Cart Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          elevation: 4,
                          shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined),
                            SizedBox(width: 8),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductHeroSection extends StatelessWidget {
  final String imageUrl;

  const ProductHeroSection({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF1F5F9), Color(0xFFE2E8F0)], // slate-100 to slate-200
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Hero(
                tag: 'product_image_$imageUrl', // Use unique tag if possible
                child: Builder(
                  builder: (context) {
                    if (imageUrl.startsWith('assets/')) {
                         return Image.asset(
                            imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                          );
                    }
                    if (imageUrl.isNotEmpty) {
                      return Image.network(
                        imageUrl,
                         fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                      );
                    }
                    return const Icon(Icons.image, size: 80, color: Colors.grey);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(context, true),
                const SizedBox(width: 8),
                _buildDot(context, false),
                const SizedBox(width: 8),
                _buildDot(context, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(BuildContext context, bool isActive) {
    return Container(
      width: isActive ? 24 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CircleIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 20, color: Colors.grey[800]),
        onPressed: onPressed,
      ),
    );
  }
}

class SpecItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const SpecItem({super.key, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 10,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.grey[800],
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class AddOnCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageAsset;

  const AddOnCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Builder(
                 builder: (context) {
                    if (imageAsset.startsWith('assets/')) {
                       return Image.asset(imageAsset, fit: BoxFit.contain);
                    }
                    return const Icon(Icons.image, color: Colors.grey);
                 }
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 28,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                side: BorderSide(color: Colors.grey[300]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'ADD',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
