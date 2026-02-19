import 'package:flutter/material.dart';
import 'package:ecomerce/app/router/app_router.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Orders Data
    final orders = [
      {
        'id': '#ORD-3321',
        'date': 'Oct 24, 2023',
        'status': 'Delivered',
        'total': 145.50,
        'items': 3,
        'images': [
          'assets/images/brake_disc.png',
          'assets/images/motor_oil.png',
          'assets/images/air_filter.png',
        ],
      },
      {
        'id': '#ORD-3320',
        'date': 'Sep 15, 2023',
        'status': 'Shipped',
        'total': 45.99,
        'items': 1,
        'images': [
          'assets/images/motor_oil.png',
        ],
      },
      {
        'id': '#ORD-3319',
        'date': 'Aug 02, 2023',
        'status': 'Processing',
        'total': 210.00,
        'items': 4,
        'images': [
          'assets/images/brake_disc.png',
          'assets/images/air_filter.png',
        ],
      },
       {
        'id': '#ORD-3318',
        'date': 'Jul 10, 2023',
        'status': 'Cancelled',
        'total': 15.00,
        'items': 1,
        'images': [
          'assets/images/air_filter.png',
        ],
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            color: Theme.of(context).iconTheme.color,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = orders[index];
                return _OrderCard(order: order);
              },
            ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (order['status']) {
      case 'Delivered':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Shipped':
        statusColor = Colors.blue;
        statusIcon = Icons.local_shipping;
        break;
      case 'Processing':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time_filled;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order['id'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order['date'],
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      order['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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

          // Content
          Row(
            children: [
              // Images
              SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (order['images'] as List).length > 3 ? 3 : (order['images'] as List).length,
                  itemBuilder: (context, imgIndex) {
                    return Container(
                      width: 48,
                      height: 48,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Image.asset(
                        (order['images'] as List)[imgIndex],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              if ((order['images'] as List).length > 3)
                Container(
                   width: 48,
                   height: 48,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                     color: Colors.grey[100],
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: Text(
                     '+${(order['images'] as List).length - 3}',
                     style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                   ),
                ),
            ],
          ),

          const SizedBox(height: 16),
          
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  Text(
                    '\$${order['total'].toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.orderDetails,
                    arguments: order,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  side: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: 0.5)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: const Size(0, 36),
                ),
                child: const Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
