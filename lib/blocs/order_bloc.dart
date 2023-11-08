import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/models/order.dart';
import 'package:resto_flow/repositories/order_repository.dart';

import 'events/order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderTableNotSetState()) {
    on<OrderSetTableEvent>(
      (event, emit) {
        emit(OrderLoadingState());
        if (event.tableId.isEmpty) emit(OrderTableNotSetState());

        OrderRepository().currentOrder = Order(
          tableId: event.tableId,
        );
        emit(OrderTableSetState(event.tableId));
      },
    );
  }
}
