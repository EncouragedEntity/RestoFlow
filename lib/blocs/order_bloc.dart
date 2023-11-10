import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/models/order.dart';
import 'package:resto_flow/models/table.dart';

import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/repositories/table_repository.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../repositories/user_repository.dart';
import '../services/stompsocket_service.dart';
import 'events/order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderTableNotSetState()) {
    on<OrderSetTableEvent>(
      (event, emit) async {
        emit(OrderLoadingState());
        if (event.tableId.isEmpty) emit(OrderTableNotSetState());

        final hostname = UserRepository.instance?.hostname ?? "";

        if (!StompSocketService.isSocketConnected) {
          await StompSocketService(
            serverLink: hostname,
            tableId: event.tableId,
            onCallback: onCallback,
          ).connect();
        }

        StompSocketService.instance!.sendMockRequest();

        final Table table =
            await TableRepository(hostname: hostname).getById(event.tableId);

        OrderRepository().currentOrder = Order(
          tableId: table.id,
          restaurantId: table.restaurantId,
        );

        emit(OrderTableSetState(event.tableId));
      },
    );

    on<OrderAddProductEvent>(
      (event, emit) {
        final hostname = UserRepository.instance!.hostname!;
        final tableId = OrderRepository().currentOrder!.tableId;

        StompSocketService(
          serverLink: hostname,
          tableId: tableId,
          onCallback: onCallback,
        ).addProductsToOrder([event.product]);
      },
    );
  }

  void onCallback(StompFrame frame) {
    final rep = OrderRepository();
    final list = rep.parseOrderProductDtos(frame.body!);

    rep.setProducts(list);
  }
}
