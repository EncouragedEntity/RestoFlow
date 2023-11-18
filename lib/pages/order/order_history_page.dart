import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/order_history_event.dart';
import 'package:resto_flow/blocs/states/order_history_state.dart';
import 'package:resto_flow/models/order/order.dart';
import 'package:resto_flow/models/order/order_user_dto.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/models/restaurant.dart';
import 'package:resto_flow/pages/order/order_details_page.dart';
import 'package:resto_flow/repositories/user_repository.dart';
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
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<OrderHistoryBloc>()
                  .add(OrderHistoryLoadEvent(authState.user.id));
            },
            child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
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
                  final users = orderHisState.userDtos;
                  final List<Order> orders = orderHisState.orders;
                  final List<OrderProductDto> products = orderHisState.products;
                  final orderRestaurants = orderHisState.orderRestaurants;

                  return Scaffold(
                    appBar: AppBar(
                      title: Text(S.current.your_orders),
                    ),
                    body: ScrollConfiguration(
                      behavior: const MaterialScrollBehavior(),
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final Order order = orders[index];
                          final OrderUserDto user = users.firstWhere(
                              (element) =>
                                  element.userId ==
                                      UserRepository.currentUser?.id &&
                                  element.orderId == order.id);
                          final Restaurant restaurant =
                              orderRestaurants.firstWhere(
                            (restaurant) => restaurant.id == order.restaurantId,
                          );
                          final orderProducts = products
                              .where((e) => e.orderId == order.id)
                              .toList();

                          return ListTile(
                            title: Row(
                              children: [
                                const Icon(Icons.restaurant),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(order.formattedDate),
                                const Spacer(),
                                Text("${user.formattedSumPaid} грн."),
                              ],
                            ),
                            subtitle: Text(
                                "${restaurant.name} | ${restaurant.address}"),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OrderDetailsPage(
                                        order, orderProducts, user),
                                  ));
                                },
                                icon: const Icon(Icons.chevron_right)),
                          );
                        },
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text(S.current.empty_here),
                );
              },
            ),
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
