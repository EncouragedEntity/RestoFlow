import 'package:flutter/material.dart';
import 'package:resto_flow/models/order/order.dart';
import 'package:resto_flow/models/order/order_user_dto.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/widgets/order/order_history_product_tile.dart';

import '../../generated/l10n.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage(this.order, this.products, this.user, {super.key});

  final Order order;
  final List<OrderProductDto> products;
  final OrderUserDto user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.your_order),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.formattedDate,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    order.formattedTime,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: products
                    .map((e) => OrderHistoryProductListTile(
                          e,
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${S.current.sum_paid}:",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${user.formattedSumPaid} грн.",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 2,
            ),
            if (order.tips != 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${S.current.tips}:",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${order.formattedTips} грн.",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
