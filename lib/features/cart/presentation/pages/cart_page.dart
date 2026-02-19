import 'package:flutter/material.dart';
import 'package:ecomerce/app/router/app_router.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Dummy Cart Data
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Bosch Premium Oil Filter',
      'partNumber': 'Part #3321 • Fits 2018 Toyota Camry',
      'price': 14.99,
      'quantity': 1,
      'image': 'assets/images/air_filter.png', // Placeholder
    },
    {
      'id': '2',
      'name': 'Ceramic Brake Pads - Front',
      'partNumber': 'Part #9982 • High Performance',
      'price': 45.50,
      'quantity': 1,
      'image': 'assets/images/brake_disc.png',
    },
    {
      'id': '3',
      'name': 'Synthetic Motor Oil 5W-30',
      'partNumber': '5 Qt Jug • Full Synthetic',
      'price': 28.00,
      'quantity': 2,
      'image': 'assets/images/motor_oil.png',
    },
  ];

  double get _subtotal => _cartItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));
  double get _shipping => 5.99;
  double get _tax => _subtotal * 0.08;
  double get _total => _subtotal + _shipping + _tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.grey[800]),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'My Cart (${_cartItems.length})',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.grey[800]),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Cart Items
                  ..._cartItems.map((item) => _CartItem(
                        item: item,
                        onRemove: () {
                          setState(() {
                            _cartItems.remove(item);
                          });
                        },
                        onIncrement: () {
                          setState(() {
                            item['quantity']++;
                          });
                        },
                        onDecrement: () {
                          setState(() {
                            if (item['quantity'] > 1) {
                              item['quantity']--;
                            }
                          });
                        },
                      )),
                  
                  const SizedBox(height: 16),
                  
                  // Promo Code
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                        style: BorderStyle.solid, // Dashed border is complex in Flutter without packages, using solid for now or custom painter
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_offer, color: Theme.of(context).primaryColor, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Add Promo Code',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor.withValues(alpha: 0.6), size: 18),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  Divider(color: Colors.grey[200]),
                  const SizedBox(height: 16),
                  
                  // Cost Breakdown
                  _CostRow(label: 'Subtotal', amount: _subtotal),
                  const SizedBox(height: 8),
                  _CostRow(label: 'Shipping', amount: _shipping),
                  const SizedBox(height: 8),
                  _CostRow(label: 'Tax (8%)', amount: _tax),
                  
                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),
          
          // Sticky Bottom Bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).textTheme.titleLarge?.color,
                                ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Free returns',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.checkout);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _CartItem({
    required this.item,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 96,
            height: 96,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(item['image'], fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          
          // Details
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
                        item['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: onRemove,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.close, size: 20, color: Colors.grey[400]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['partNumber'],
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    
                    // Quantity
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            onPressed: onDecrement,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            constraints: const BoxConstraints(),
                            color: Colors.grey[600],
                          ),
                          Text(
                            '${item['quantity']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            onPressed: onIncrement,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            constraints: const BoxConstraints(),
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
