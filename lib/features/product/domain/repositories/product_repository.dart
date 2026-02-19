import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/errors.dart';
import 'package:ecomerce/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProduct(String id);
}
