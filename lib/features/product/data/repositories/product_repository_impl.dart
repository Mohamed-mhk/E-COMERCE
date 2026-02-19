import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/errors.dart';
import 'package:ecomerce/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecomerce/features/product/domain/entities/product.dart';
import 'package:ecomerce/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getProducts();
      return Right(remoteProducts);
    } catch (e) {
      // Handle exception mapping here (e.g., from DioException to ServerFailure)
       // This is a simplified example
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }
}
