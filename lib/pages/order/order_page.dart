import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/services/stompsocket_service.dart';
import 'package:resto_flow/widgets/my_themed_button.dart';
import 'package:resto_flow/widgets/order/order_product_list_tile.dart';
import 'package:resto_flow/widgets/page_blocker.dart';

import '../../generated/l10n.dart';
import '../../models/products/product.dart';

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
  List<OrderProductDto> productDtos = OrderRepository().getProducts;

  void onIncrease(Product product) async {
    StompSocketService.instance!.addProductsToOrder([product]);
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      productDtos = OrderRepository().getProducts;
    });
  }

  void onDecrease(Product product) async {
    StompSocketService.instance!.removeProductsFromOrder([product]);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      productDtos = OrderRepository().getProducts;
    });
  }

  void onDelete(Product product) async {
    StompSocketService.instance!.deleteProductFromOrder(
      product.id,
      productDtos
          .firstWhere((element) => element.productId == product.id)
          .quantity,
    );
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      productDtos = OrderRepository().getProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pageContent = SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.order),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(
                  // ignore: deprecated_member_use
                  androidOverscrollIndicator:
                      AndroidOverscrollIndicator.stretch,
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      productDtos = OrderRepository().getProducts;
                    });
                  },
                  child: ListView(
                    children: productDtos
                        .map((e) => OrderProductListTile(
                              e,
                              onInscrease: onIncrease,
                              onDecrease: onDecrease,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MyThemedButton(
                height: 50,
                onPressed: () {},
                child: const Text("Order"),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );

    if (productDtos.isEmpty) {
      pageContent = PageBlocker(
        appBarKey: widget.appBarKey,
        destinationIndex: 0,
        text: "Empty here, try to order something",
        buttonText: "Go to menu",
      );
    }

    if (OrderRepository().currentOrder == null) {
      pageContent = PageBlocker(
        appBarKey: widget.appBarKey,
        destinationIndex: 2,
        text: S.current.scan_first,
        buttonText: S.current.go_to_scan,
      );
    }
    return pageContent;
  }
}
