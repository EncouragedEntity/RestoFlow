import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/order_history_event.dart';
import 'package:resto_flow/blocs/states/order_history_state.dart';
import 'package:resto_flow/models/order/order_history_response_dto.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/models/restaurant.dart';
import 'package:resto_flow/repositories/order_history_repository.dart';

import '../models/order/order.dart';
import '../repositories/restaurant_repository.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitialState()) {
    on<OrderHistoryLoadEvent>(
      (event, emit) async {
        emit(OrderHistoryLoadingState());
        if (event.userId == null) {
          emit(OrderHistoryLoadFailureState());
          return;
        }
        final List<OrderHistoryResponseDto> list =
            await OrderHistoryRepository().getHistory(event.userId!);

        final userDtos = list.map((e) => e.orderUserDto).toList();
        final List<Order> orders =
            list.map((e) => e.orderDto).toList().reversed.toList();
        final List<Restaurant> orderRestaurants = await Future.wait(
          orders.map(
              (order) => RestaurantRepository().getById(order.restaurantId!)),
        );
        final List<OrderProductDto> productDtos = list
            .expand((orderHistoryResponseDto) =>
                orderHistoryResponseDto.orderProductDtos)
            .toList();

        if (list.isEmpty) {
          emit(OrderHistoryEmptyState());
          return;
        }
        emit(OrderHistoryLoadedState(
            userDtos, orders, productDtos, orderRestaurants));
      },
    );
  }
}
