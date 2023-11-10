import 'package:equatable/equatable.dart';

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
