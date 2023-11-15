import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/order_history_event.dart';
import 'package:resto_flow/blocs/states/order_history_state.dart';
import 'package:resto_flow/repositories/order_history_repository.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryInitialState()) {
    on<OrderHistoryLoadEvent>(
      (event, emit) async {
        emit(OrderHistoryLoadingState());
        if (event.userId == null) {
          emit(OrderHistoryLoadFailureState());
          return;
        }
        final list = await OrderHistoryRepository().getHistory(event.userId!);
        if (list.isEmpty) {
          emit(OrderHistoryEmptyState());
          return;
        }
        emit(OrderHistoryLoadedState(list));
      },
    );
  }
}
