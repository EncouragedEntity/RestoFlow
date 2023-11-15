import 'package:equatable/equatable.dart';

import '../../models/payment/card_details.dart';
import '../../models/products/product.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderSetTableEvent extends OrderEvent {
  final String tableId;

  OrderSetTableEvent({required this.tableId});

  @override
  List<Object> get props => [tableId];
}

class OrderAddProductEvent extends OrderEvent {
  final Product product;

  OrderAddProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class OrderCheckoutEvent extends OrderEvent {
  final CardDetails card;
  final String? email;
  final int? userId;
  final double amount;

  OrderCheckoutEvent(this.card, this.email, this.userId, this.amount);
  @override
  List<Object> get props => [card, amount];
}

class OrderSetStatusEvent extends OrderEvent {
  final String status;

  OrderSetStatusEvent(this.status);
  @override
  List<Object> get props => [status];
}

class OrderGetHistoryEvent extends OrderEvent {
  final int userId;

  OrderGetHistoryEvent(this.userId);
  @override
  List<Object> get props => [userId];
}
