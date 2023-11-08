import 'package:equatable/equatable.dart';

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
