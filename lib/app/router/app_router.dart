import 'package:flutter/material.dart';
import 'package:ecomerce/features/home/presentation/pages/home_page.dart';
import 'package:ecomerce/features/product/presentation/pages/categories_page.dart';
import 'package:ecomerce/features/product/presentation/pages/product_details_page.dart';
import 'package:ecomerce/features/cart/presentation/pages/cart_page.dart';
import 'package:ecomerce/features/cart/presentation/pages/checkout_page.dart';
import 'package:ecomerce/features/orders/presentation/pages/orders_page.dart';
import 'package:ecomerce/features/orders/presentation/pages/order_details_page.dart';
import 'package:ecomerce/features/orders/presentation/pages/order_tracking_page.dart';

class AppRouter {
  static const String home = '/';
  static const String categories = '/categories';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String orderDetails = '/order-details';
  static const String orderTracking = '/order-tracking';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoriesPage());
      case productDetails:
        final product = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(product: product),
        );
      case cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutPage());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersPage());
      case orderDetails:
        final order = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OrderDetailsPage(order: order),
        );
      case orderTracking:
        final order = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OrderTrackingPage(order: order),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
