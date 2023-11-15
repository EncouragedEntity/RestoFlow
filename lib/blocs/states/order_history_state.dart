import 'package:equatable/equatable.dart';

import '../../models/order/order_history_response_dto.dart';

abstract class OrderHistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderHistoryInitialState extends OrderHistoryState {}

class OrderHistoryLoadingState extends OrderHistoryState {}

class OrderHistoryLoadedState extends OrderHistoryState {
  final List<OrderHistoryResponseDto> orderHistoryList;

  OrderHistoryLoadedState(this.orderHistoryList);

  @override
  List<Object> get props => [orderHistoryList];
}

class OrderHistoryLoadFailureState extends OrderHistoryState {}

class OrderHistoryEmptyState extends OrderHistoryState {}
