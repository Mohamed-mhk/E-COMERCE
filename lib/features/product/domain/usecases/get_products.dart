import 'package:dartz/dartz.dart';
import 'package:ecomerce/core/errors.dart';
import 'package:ecomerce/core/utils/usecase.dart';
import 'package:ecomerce/features/product/domain/entities/product.dart';
import 'package:ecomerce/features/product/domain/repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
