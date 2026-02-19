import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedAddressIndex = 0; // 0: Home, 1: Workshop
  int _selectedDeliveryIndex = 0; // 0: Standard, 1: Express

  final List<Map<String, dynamic>> _addresses = [
    {
      'type': 'Home',
      'isDefault': true,
      'name': 'Alex Mechanic',
      'address': '1245 Spark Plug Lane, Unit 4B\nDetroit, MI 48201',
      'icon': Icons.home,
    },
    {
      'type': 'Workshop',
      'isDefault': false,
      'name': 'Alex Mechanic',
      'address': '880 Gearbox Ave\nDetroit, MI 48202',
      'icon': Icons.work,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          'Checkout',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Column(
        children: [
          // Stepper
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            color: Theme.of(context).cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStep(Icons.local_shipping, 'Shipping', true, context),
                Expanded(child: Container(height: 2, color: Colors.grey[300])),
                _buildStep(Icons.credit_card, 'Payment', false, context),
                Expanded(child: Container(height: 2, color: Colors.grey[300])),
                _buildStep(Icons.assignment, 'Review', false, context),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shipping Address Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping Address',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '+ Add New',
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(_addresses.length, (index) {
                    final address = _addresses[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAddressIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedAddressIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey.withValues(alpha: 0.2),
                            width: _selectedAddressIndex == index ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _selectedAddressIndex == index
                                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                                        : Colors.grey[100],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    address['icon'] as IconData,
                                    color: _selectedAddressIndex == index
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[500],
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            address['type'] as String,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                          if (address['isDefault'] as bool) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                'DEFAULT',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        address['name'] as String,
                                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                      ),
                                      Text(
                                        address['address'] as String,
                                        style: TextStyle(color: Colors.grey[500], fontSize: 13, height: 1.4),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_selectedAddressIndex == index)
                                  Icon(Icons.check_circle, color: Theme.of(context).primaryColor),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 16),

                  // Delivery Method Section
                  Text(
                    'Delivery Method',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                         _buildDeliveryOption(
                          index: 0,
                          title: 'Standard Shipping',
                          price: 'Free',
                          arrival: 'Arrives Tue, Oct 24',
                          context: context,
                        ),
                        Divider(height: 1, color: Colors.grey[200]),
                        _buildDeliveryOption(
                          index: 1,
                          title: 'Express Delivery',
                          price: '\$12.99',
                          arrival: 'Arrives Tomorrow, Oct 20',
                          context: context,
                        ),
                      ],
                    ),
                  ),

                   const SizedBox(height: 100), // Bottom padding
                ],
              ),
            ),
          ),
          
          // Sticky Bottom Bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
                    children: [
                       Text('Total (3 items)', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                       Text(
                        '\$342.50', // Mock Total
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
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
                         // Navigate to Payment
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue to Payment',
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

  Widget _buildStep(IconData icon, String label, bool isActive, BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
            shape: BoxShape.circle,
            border: isActive ? null : Border.all(color: Colors.grey[300]!),
            boxShadow: isActive ? [
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ] : [],
          ),
          child: Icon(
            icon,
            size: 16,
            color: isActive ? Colors.white : Colors.grey[400],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isActive ? Theme.of(context).primaryColor : Colors.grey[400],
          ),
          ),
      ],
    );
  }

  Widget _buildDeliveryOption({
    required int index,
    required String title,
    required String price,
    required String arrival,
    required BuildContext context,
  }) {
    final isSelected = _selectedDeliveryIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDeliveryIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey[400],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      Text(
                        price,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    arrival,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
