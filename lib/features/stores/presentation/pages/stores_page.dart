import 'package:flutter/material.dart';

class StoresPage extends StatelessWidget {
  const StoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Stores matching Stitch UI
    final stores = [
      {
        'name': 'Downtown Auto Parts',
        'distance': '1.2 miles away',
        'status': 'Open until 8 PM',
        'icon': Icons.storefront, 
        'features': ['local_shipping', 'verified'],
      },
      {
        'name': 'Northside Spares',
        'distance': '2.5 miles away',
        'status': 'Open until 6 PM',
        'icon': Icons.build_circle,
        'rating': '4.8',
        'reviews': '(120)',
      },
      {
        'name': 'Elite Performance Hub',
        'distance': '4.1 miles away',
        'status': 'Open until 9 PM',
        'icon': Icons.precision_manufacturing,
        'expressPickup': true,
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide back button if navigating from bottom bar
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 0, // Custom header in body
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nearby Stores',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.titleLarge?.color,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Find local auto parts near you.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.map_outlined, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                   color: Theme.of(context).cardColor,
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withValues(alpha: 0.05),
                       blurRadius: 10,
                       offset: const Offset(0, 4),
                     ),
                   ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for local stores...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.transparent, 
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Stores List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: stores.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final store = stores[index];
                  return _StoreCard(store: store);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  final Map<String, dynamic> store;

  const _StoreCard({required this.store});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: store['name'] == 'Downtown Auto Parts' 
                      ? primaryColor.withValues(alpha: 0.1) 
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  store['icon'] as IconData,
                  color: store['name'] == 'Downtown Auto Parts' ? primaryColor : Colors.grey[500],
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            store['name'],
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                          ),
                        ),
                        Text(
                          store['distance'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      store['status'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          
          // Bottom Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Features
              if (store.containsKey('features'))
                Row(
                  children: (store['features'] as List).map<Widget>((feature) {
                    return Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: 8), // Overlap effect handled by not adding neg margin for simplicity or add Negative margin in Stack
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                         feature == 'local_shipping' ? Icons.local_shipping : Icons.verified,
                         size: 12, 
                         color: Colors.grey[400]
                      ),
                    );
                  }).toList(),
                )
              else if (store.containsKey('rating'))
                 Row(
                   children: [
                     const Icon(Icons.star, color: Colors.amber, size: 16),
                     const SizedBox(width: 4),
                     Text(
                       store['rating'],
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 12,
                         color: Colors.grey[700],
                       ),
                     ),
                     const SizedBox(width: 2),
                     Text(
                       store['reviews'],
                       style: TextStyle(fontSize: 10, color: Colors.grey[400]),
                     ),
                   ],
                 )
              else if (store.containsKey('expressPickup'))
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text(
                      'Express Pickup Available',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),


              // View Store Button
              store['name'] == 'Downtown Auto Parts'
                  ? ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text('View Store'),
                    )
                  : OutlinedButton(
                      onPressed: () {},
                       style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: BorderSide(color: primaryColor.withValues(alpha: 0.3)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text('View Store'),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
