import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/models/products/product_dtos_list.dart';
import 'package:resto_flow/pages/checkout_page.dart';
import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:resto_flow/services/stompsocket_service.dart';
import 'package:resto_flow/widgets/my_themed_button.dart';
import 'package:resto_flow/widgets/order/order_product_list_tile.dart';
import 'package:resto_flow/widgets/page_blocker.dart';

import '../../blocs/events/order_event.dart';
import '../../data/string_constants.dart';
import '../../generated/l10n.dart';
import '../../models/products/product.dart';
import '../../widgets/my_themed_alert.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
    required this.appBarKey,
  });

  final GlobalKey<ConvexAppBarState> appBarKey;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final ProductDtosList productDtosList = OrderRepository().list;

  void onIncrease(Product product) async {
    StompSocketService.instance!.addProductsToOrder([product]);
    await Future.delayed(const Duration(milliseconds: 250));

    productDtosList.notifyListeners();
  }

  void onDecrease(Product product) async {
    StompSocketService.instance!.removeProductsFromOrder([product]);
    await Future.delayed(const Duration(milliseconds: 250));

    productDtosList.notifyListeners();
  }

  void onDelete(Product product) async {
    StompSocketService.instance!.deleteProductFromOrder(
      product.id,
      productDtosList.productDtos
          .firstWhere((element) => element.productId == product.id)
          .quantity,
    );
    await Future.delayed(const Duration(milliseconds: 250));
    productDtosList.notifyListeners();
  }

  Future<void> onRefresh() async {
    setState(() {
      StompSocketService.instance!.sendMockRequest();
    });
    productDtosList.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent = PageBlocker(
      appBarKey: widget.appBarKey,
      destinationIndex: 0,
      text: S.current.empty_here,
      buttonText: S.current.go_to_menu,
    );

    if (OrderRepository().currentOrder != null) {
      pageContent = PageBlocker(
        appBarKey: widget.appBarKey,
        destinationIndex: 2,
        text: S.current.scan_first,
        buttonText: S.current.go_to_scan,
      );
    }

    pageContent = ChangeNotifierProvider.value(
      value: productDtosList,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.your_order),
          ),
          body: Consumer2<OrderRepository, ProductDtosList>(
            builder: (context, orderRepository, productDtosList, child) {
              List<OrderProductDto> productDtos = productDtosList.productDtos;

              if (productDtosList.productDtos.isEmpty) {
                return PageBlocker(
                  appBarKey: widget.appBarKey,
                  destinationIndex: 0,
                  text: S.current.empty_here,
                  buttonText: S.current.go_to_menu,
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const MaterialScrollBehavior(),
                      child: RefreshIndicator(
                        onRefresh: onRefresh,
                        child: ListView(
                          children: productDtos
                              .map((e) => OrderProductListTile(
                                    e,
                                    onInscrease: onIncrease,
                                    onDecrease: onDecrease,
                                    onDelete: onDelete,
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${OrderRepository().currentOrder?.formattedSumToPay ?? 0} грн.",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                    thickness: 2,
                  ),
                  if (OrderRepository().currentOrder?.status ==
                      orderStatusChoosing)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MyThemedButton(
                        height: 50,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return MyThemedAlert(
                                title: Text(S.current.confirm_order),
                                content: Text(S.current.confirm_order_text),
                                actions: <Widget>[
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStatePropertyAll(
                                        Theme.of(context).highlightColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(S.current.cancel),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStatePropertyAll(
                                        Theme.of(context).highlightColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        context.read<OrderBloc>().add(
                                              OrderSetStatusEvent(
                                                orderStatusOrdered,
                                              ),
                                            );
                                      });

                                      Navigator.pop(context);
                                    },
                                    child: Text(S.current.order),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(S.current.order),
                      ),
                    ),
                  if (OrderRepository().currentOrder?.status ==
                      orderStatusReady)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MyThemedButton(
                        height: 50,
                        onPressed: () {
                          if (OrderRepository().currentOrder!.status ==
                              orderStatusReady) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) {
                                  return CheckoutPage(
                                    isAuthenticated:
                                        UserRepository.currentUser != null,
                                    context: context,
                                  );
                                },
                              ),
                            ).then((value) => onRefresh());
                          }
                        },
                        child: Text(S.current.pay),
                      ),
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    return pageContent;
  }
}
