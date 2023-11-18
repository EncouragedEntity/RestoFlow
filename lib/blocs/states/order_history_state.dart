import 'package:equatable/equatable.dart';
import 'package:resto_flow/models/order/order_user_dto.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/models/restaurant.dart';

import '../../models/order/order.dart';

abstract class OrderHistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderHistoryInitialState extends OrderHistoryState {}

class OrderHistoryLoadingState extends OrderHistoryState {}

class OrderHistoryLoadedState extends OrderHistoryState {
  final List<OrderUserDto> userDtos;
  final List<Order> orders;
  final List<OrderProductDto> products;
  final List<Restaurant> orderRestaurants;

  OrderHistoryLoadedState(
      this.userDtos, this.orders, this.products, this.orderRestaurants);

  @override
  List<Object> get props => [
        userDtos,
        orders,
        products,
        orderRestaurants,
      ];
}

class OrderHistoryLoadFailureState extends OrderHistoryState {}

class OrderHistoryEmptyState extends OrderHistoryState {}
