
import 'package:ecomerce/core/network/dio_consumer.dart';
import 'package:ecomerce/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioConsumer dioConsumer;

  ProductRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<List<ProductModel>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      const ProductModel(
        id: '1',
        name: 'Smartphone X',
        description: 'Latest model with high-res camera and fast processor.',
        price: 999.99,
        imageUrl: 'assets/images/spark_plug.png',
      ),
      const ProductModel(
        id: '2',
        name: 'Laptop Pro',
        description: 'Powerful laptop for professionals and creatives.',
        price: 1499.50,
        imageUrl: 'assets/images/brake_disc.png',
      ),
      const ProductModel(
        id: '3',
        name: 'Wireless Headphones',
        description: 'Noise-cancelling over-ear headphones.',
        price: 299.00,
        imageUrl: 'assets/images/air_filter.png',
      ),
      const ProductModel(
        id: '4',
        name: 'Smart Watch',
        description: 'Track your fitness and notifications.',
        price: 199.99,
        imageUrl: 'assets/images/motor_oil.png',
      ),
       const ProductModel(
        id: '5',
        name: 'Running Shoes',
        description: 'Comfortable shoes for long-distance running.',
        price: 89.95,
        imageUrl: 'assets/images/brake_disc.png',
      ),
      const ProductModel(
        id: '6',
        name: 'Leather Bag',
        description: 'Stylish leather bag for everyday use.',
        price: 120.00,
        imageUrl: 'assets/images/motor_oil.png',
      ),
    ];
    /*
    final response = await dioConsumer.get('/products');
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } else {
      throw const ServerFailure('Failed to fetch products');
    }
    */
  }
}
