import 'package:ecomerce/features/product/data/datasources/product_remote_data_source.dart';
import 'package:ecomerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecomerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecomerce/features/product/domain/usecases/get_products.dart';
import 'package:ecomerce/features/product/presentation/bloc/product_bloc.dart';

import 'package:dio/dio.dart';
import 'package:ecomerce/core/network/dio_consumer.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Product
  // Bloc
  sl.registerFactory(() => ProductBloc(getProducts: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dioConsumer: sl()),
  );
  
  // Core
  sl.registerLazySingleton<DioConsumer>(() => DioConsumerImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => Dio());
}
