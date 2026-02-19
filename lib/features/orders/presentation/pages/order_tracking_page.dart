import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderTrackingPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Determine current step based on status
    int currentStep;
    switch (order['status']) {
      case 'Processing':
        currentStep = 0;
        break;
      case 'Shipped':
        currentStep = 2;
        break;
      case 'Delivered':
        currentStep = 3;
        break;
      default:
        currentStep = 0;
    }

    final trackingSteps = [
      {
        'title': 'Order Confirmed',
        'subtitle': 'Your order has been placed',
        'time': 'Oct 20, 10:30 AM',
        'icon': Icons.check_circle,
      },
      {
        'title': 'Processing',
        'subtitle': 'Your order is being prepared',
        'time': 'Oct 21, 2:15 PM',
        'icon': Icons.inventory_2,
      },
      {
        'title': 'Shipped',
        'subtitle': 'On its way to you',
        'time': 'Oct 22, 9:00 AM',
        'icon': Icons.local_shipping,
      },
      {
        'title': 'Delivered',
        'subtitle': 'Package delivered',
        'time': 'Oct 24, 3:45 PM',
        'icon': Icons.home,
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Map Area
          Stack(
            children: [
              // Map Placeholder
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Stack(
                  children: [
                    // Stylized map background
                    CustomPaint(
                      size: Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.45,
                      ),
                      painter: _MapPainter(),
                    ),

                    // Route line
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _RoutePainter(
                          progress: currentStep / 3,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),

                    // Origin marker
                    Positioned(
                      left: 60,
                      bottom: 100,
                      child: _MapMarker(
                        icon: Icons.store,
                        label: 'Warehouse',
                        color: Colors.blue[700]!,
                      ),
                    ),

                    // Destination marker
                    Positioned(
                      right: 50,
                      top: 80,
                      child: _MapMarker(
                        icon: Icons.home,
                        label: 'Your Address',
                        color: Colors.green[700]!,
                      ),
                    ),

                    // Delivery truck
                    if (order['status'] == 'Shipped')
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.4,
                        top: MediaQuery.of(context).size.height * 0.18,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.local_shipping, color: Colors.white, size: 24),
                        ),
                      ),
                  ],
                ),
              ),

              // Back button & Title overlay
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.grey[800]),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Track Order',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ETA Card overlay
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.access_time_filled, color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Estimated Delivery',
                              style: TextStyle(color: Colors.grey[500], fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              order['status'] == 'Delivered'
                                  ? 'Delivered on ${order['date']}'
                                  : 'Oct 24, 2023 • 2:00 - 5:00 PM',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: order['status'] == 'Delivered'
                              ? Colors.green[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          order['status'] == 'Delivered' ? 'Delivered' : 'In Transit',
                          style: TextStyle(
                            color: order['status'] == 'Delivered'
                                ? Colors.green[700]
                                : Colors.orange[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Tracking Timeline
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tracking Details',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          order['id'],
                          style: TextStyle(color: Colors.grey[500], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                      itemCount: trackingSteps.length,
                      itemBuilder: (context, index) {
                        final step = trackingSteps[index];
                        final isCompleted = index <= currentStep;
                        final isActive = index == currentStep;
                        final isLast = index == trackingSteps.length - 1;

                        return _TrackingStep(
                          title: step['title'] as String,
                          subtitle: step['subtitle'] as String,
                          time: step['time'] as String,
                          icon: step['icon'] as IconData,
                          isCompleted: isCompleted,
                          isActive: isActive,
                          isLast: isLast,
                          primaryColor: Theme.of(context).primaryColor,
                        );
                      },
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

// --- Custom Widgets ---

class _MapMarker extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MapMarker({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrackingStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final bool isCompleted;
  final bool isActive;
  final bool isLast;
  final Color primaryColor;

  const _TrackingStep({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.isCompleted,
    required this.isActive,
    required this.isLast,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? (isActive ? primaryColor : primaryColor.withValues(alpha: 0.15))
                      : Colors.grey[100],
                  shape: BoxShape.circle,
                  border: isActive
                      ? Border.all(color: primaryColor.withValues(alpha: 0.3), width: 3)
                      : null,
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: isCompleted
                      ? (isActive ? Colors.white : primaryColor)
                      : Colors.grey[400],
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 40,
                  color: isCompleted ? primaryColor.withValues(alpha: 0.3) : Colors.grey[200],
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isCompleted ? null : Colors.grey[400],
                        ),
                      ),
                      if (isCompleted)
                        Text(
                          time,
                          style: TextStyle(color: Colors.grey[500], fontSize: 11),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isCompleted ? Colors.grey[500] : Colors.grey[300],
                      fontSize: 13,
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

// --- Custom Painters ---

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw grid lines to simulate a map
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw "roads"
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Horizontal roads
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.6),
      Offset(size.width, size.height * 0.6),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.8),
      Offset(size.width, size.height * 0.8),
      roadPaint,
    );

    // Vertical roads
    canvas.drawLine(
      Offset(size.width * 0.25, 0),
      Offset(size.width * 0.25, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.55, 0),
      Offset(size.width * 0.55, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.8, 0),
      Offset(size.width * 0.8, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoutePainter extends CustomPainter {
  final double progress;
  final Color color;

  _RoutePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(80, size.height - 90)
      ..cubicTo(
        size.width * 0.3, size.height * 0.6,
        size.width * 0.5, size.height * 0.4,
        size.width - 60, 100,
      );

    // Draw dashed background
    final bgPaint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    _drawDashedPath(canvas, path, bgPaint);

    // Draw active route
    final activePaint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final metrics = path.computeMetrics().first;
    final activePath = metrics.extractPath(0, metrics.length * progress);
    canvas.drawPath(activePath, activePaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + 8).clamp(0, metric.length).toDouble();
        final segment = metric.extractPath(distance, end);
        canvas.drawPath(segment, paint);
        distance += 16;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
