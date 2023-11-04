import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/repositories/category_repository.dart';
import 'package:resto_flow/repositories/product_repository.dart';

import '../repositories/user_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<ProductShowAllEvent>((event, emit) async {
      emit(ProductLoading());

      final hostname = UserRepository.instance?.hostname ?? "error";

      final products = await ProductRepository(
        hostname: hostname,
      ).getAll();

      final categories = await CategoryRepository(
        hostname: hostname,
      ).getAll();

      emit(ProductAllState(
        categories,
        products,
      ));
    });

    on<ProductShowDetailsEvent>((event, emit) {
      emit(ProductDetailsState(event.product));
    });

    on<ProductAddToOrderEvent>((event, emit) {
      // TODO add "add to order" logic
    });
  }
}
