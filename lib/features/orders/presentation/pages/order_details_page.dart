import 'package:flutter/material.dart';
import 'package:ecomerce/app/router/app_router.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    
    // Mock items data (in a real app, this would come from the order object)
    final List<Map<String, dynamic>> items = [
      {
        'name': 'Bosch Premium Oil Filter',
        'partNumber': 'Part #3321',
        'quantity': 1,
        'price': 14.99,
        'image': 'assets/images/air_filter.png',
      },
      {
        'name': 'Synthetic Motor Oil 5W-30',
        'partNumber': '5 Qt Jug',
        'quantity': 2,
        'price': 28.00,
        'image': 'assets/images/motor_oil.png',
      },
    ];

    Color statusColor;
    IconData statusIcon;
    Color statusBgColor;

    switch (order['status']) {
      case 'Delivered':
        statusColor = Colors.green[700]!;
        statusBgColor = Colors.green[50]!;
        statusIcon = Icons.check_circle;
        break;
      case 'Shipped':
        statusColor = Colors.blue[700]!;
        statusBgColor = Colors.blue[50]!;
        statusIcon = Icons.local_shipping;
        break;
      case 'Processing':
        statusColor = Colors.orange[700]!;
        statusBgColor = Colors.orange[50]!;
        statusIcon = Icons.schedule;
        break;
      case 'Cancelled':
        statusColor = Colors.red[700]!;
        statusBgColor = Colors.red[50]!;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey[700]!;
        statusBgColor = Colors.grey[50]!;
        statusIcon = Icons.info;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.grey[800]),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(statusIcon, color: statusColor, size: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    order['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Order ${order['id']}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _DetailItem(label: 'Order Date', value: order['date']),
                      _DetailItem(label: 'Tracking Number', value: 'TRK-88592103'), // Mock
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Items List
            Text(
              'Items Ordered',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[50], // Light gray background for image
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(item['image'], fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['partNumber'],
                              style: TextStyle(color: Colors.grey[500], fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'x${item['quantity']}',
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 24),

            // Payment & Shipping Info
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _SummaryRow(label: 'Payment Method', value: '•••• 4242', icon: Icons.credit_card),
                  const SizedBox(height: 16),
                  _SummaryRow(label: 'Shipping Address', value: '1245 Spark Plug Lane...', icon: Icons.location_on),
                  const SizedBox(height: 24),
                  const Divider(height: 1),
                  const SizedBox(height: 24),
                  _CostRow(label: 'Subtotal', amount: order['total'] - 10.0), // Mock calc
                  const SizedBox(height: 8),
                  const _CostRow(label: 'Shipping', amount: 5.0),
                  const SizedBox(height: 8),
                  const _CostRow(label: 'Tax', amount: 5.0),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '\$${order['total'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Track Order Button
            if (order['status'] != 'Cancelled')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.orderTracking,
                      arguments: order,
                    );
                  },
                  icon: const Icon(Icons.map_outlined),
                  label: const Text('Track Order'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      foregroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Download Invoice'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Reorder'),
                  ),
                ),
              ],
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryRow({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Colors.grey[600]),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}

class _CostRow extends StatelessWidget {
  final String label;
  final double amount;

  const _CostRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }
}
