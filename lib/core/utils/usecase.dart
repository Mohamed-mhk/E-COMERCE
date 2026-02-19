import 'package:ecomerce/core/errors.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<TypeT, Params> {
  Future<Either<Failure, TypeT>> call(Params params);
}

class NoParams {
  // Empty class for use cases that don't need parameters
}
