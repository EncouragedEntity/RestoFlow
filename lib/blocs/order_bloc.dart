import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/models/payment/payment_result.dart';
import 'package:resto_flow/models/table.dart';

import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/repositories/payment_repository.dart';
import 'package:resto_flow/repositories/table_repository.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../data/string_constants.dart';
import '../models/order/order.dart';
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

        await StompSocketService(
          tableId: event.tableId,
          onCallback: onCallback,
        ).connect();

        final Table table =
            await TableRepository(hostname: hostname).getById(event.tableId);

        OrderRepository().currentOrder = Order(
          tableId: table.id,
          restaurantId: table.restaurantId,
          status: orderStatusChoosing,
        );

        StompSocketService.instance!.sendMockRequest();

        emit(OrderTableSetState(event.tableId));
      },
    );

    on<OrderAddProductEvent>(
      (event, emit) {
        if (OrderRepository().currentOrder!.status == orderStatusChoosing) {
          final tableId = OrderRepository().currentOrder!.tableId;

          StompSocketService(
            tableId: tableId,
            onCallback: onCallback,
          ).addProductsToOrder([event.product]);
        }
      },
    );

    on<OrderCheckoutEvent>(
      (event, emit) async {
        final card = event.card;
        final email = event.email;
        final userId = event.userId;
        final amount = event.amount;

        final result = await PaymentRepository().payTheCheck(
          card,
          email,
          userId,
          amount,
        );

        if (result == PaymentResult.success) {
          emit(OrderPaymentSuccessState());
          return;
        }

        emit(OrderPaymentFailureState());
      },
    );

    on<OrderSetStatusEvent>(
      (event, emit) {
        final status = event.status;

        try {
          StompSocketService.instance!.setOrderStatus(status);
        } on Exception catch (e) {
          Logger().e(e.toString());
        }

        OrderRepository().currentOrder!.status = status;
        OrderRepository().notifyListeners();
      },
    );
  }

  void onCallback(StompFrame frame) {
    final rep = OrderRepository();
    final order = Order.fromJson(jsonDecode(frame.body!)['orderDto']);
    final list = rep.parseOrderProductDtos(frame.body!);
    OrderRepository().currentOrder = order;

    rep.setProducts(list);
  }
}
