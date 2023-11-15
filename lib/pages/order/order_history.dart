import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/order_history_event.dart';
import 'package:resto_flow/blocs/states/order_history_state.dart';
import 'package:resto_flow/widgets/page_blocker.dart';

import '../../blocs/auth_bloc.dart';
import '../../blocs/order_history_bloc.dart';
import '../../blocs/states/auth_state.dart';
import '../../generated/l10n.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key, required this.appBarKey});

  final GlobalKey<ConvexAppBarState> appBarKey;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (authCtx, authState) {
        if (authState is AuthAuthenticated) {
          return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
            builder: (orderHisCtx, orderHisState) {
              if (orderHisState is OrderHistoryInitialState) {
                context
                    .read<OrderHistoryBloc>()
                    .add(OrderHistoryLoadEvent(authState.user.id));

                return Center(
                  child: Text(S.current.empty_here),
                );
              }
              if (orderHisState is OrderHistoryLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (orderHisState is OrderHistoryLoadedState) {
                final dataList = orderHisState.orderHistoryList;
                return SingleChildScrollView(
                  child: ListView(
                    children: dataList
                        .map(
                          (e) => Text(
                            e.orderProductDtos[0].quantity.toString(),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return Center(
                child: Text(S.current.empty_here),
              );
            },
          );
        }
        return PageBlocker(
          appBarKey: appBarKey,
          destinationIndex: 4,
          text: S.current.login_first,
          buttonText: S.current.go_to_login,
        );
      },
    );
  }
}
