import 'package:equatable/equatable.dart';

abstract class OrderHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderHistoryLoadEvent extends OrderHistoryEvent {
  final int? userId;

  OrderHistoryLoadEvent(this.userId);

  @override
  List<Object> get props => [];
}
