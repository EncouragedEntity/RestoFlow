import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderTableNotSetState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderTableSetState extends OrderState {
  final String tableId;

  OrderTableSetState(this.tableId);
  @override
  List<Object> get props => [tableId];
}
