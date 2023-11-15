import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/repositories/category_repository.dart';
import 'package:resto_flow/repositories/measurement_unit_repository.dart';
import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/repositories/product_repository.dart';

import '../models/order/order.dart';
import '../repositories/user_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<ProductShowAllEvent>((event, emit) async {
      if (event.products == null || event.categories == null) {
        emit(ProductLoading());

        final hostname = UserRepository.instance?.hostname ?? "error";

        final Order currentOrder = OrderRepository().currentOrder!;

        final categories = await CategoryRepository(
          hostname: hostname,
        ).getAll(currentOrder.restaurantId!);

        final products = await ProductRepository(
          hostname: hostname,
        ).getAll(currentOrder.restaurantId!);

        await MeasurementUnitRepository().getAll();

        emit(ProductAllState(
          categories: categories,
          products: products,
          displayMode: event.displayMode,
          selectedTab: event.selectedTab,
        ));
        return;
      }
      emit(ProductAllState(
        categories: event.categories!,
        products: event.products!,
        displayMode: event.displayMode,
        selectedTab: event.selectedTab,
      ));
    });

    on<ProductShowDetailsEvent>((event, emit) {
      emit(ProductDetailsState(
        event.product,
        event.displayMode,
        event.selectedTab,
      ));
    });
  }
}
