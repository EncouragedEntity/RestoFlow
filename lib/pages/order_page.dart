import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../repositories/order_repository.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.order),
        ),
        body: ListView(
          children:
              OrderRepository().getProducts.map((e) => Text(e.name)).toList(),
        ),
      ),
    );
  }
}
