import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ecomerce/core/utils/usecase.dart';
import 'package:ecomerce/features/product/domain/entities/product.dart';
import 'package:ecomerce/features/product/domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc({required this.getProducts}) : super(ProductInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await getProducts(NoParams());
      result.fold(
        (failure) => emit(ProductError(message: failure.message)),
        (products) => emit(ProductLoaded(products: products)),
      );
    });
  }
}
