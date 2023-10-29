import 'package:flutter/material.dart';
import 'package:resto_flow/widgets/products/product_detail_icon.dart';

import '../../models/products/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Card(
        color: Theme.of(context).primaryColor.withAlpha(100),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            Image.network(
              height: 200,
              width: 200,
              'https://placehold.co/200x200/png',
            ),
            const SizedBox(height: 30),
            Text(product.name),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProductDetailIcon(
                  icon: const Icon(Icons.attach_money),
                  text: Text(product.price.toStringAsFixed(2)),
                ),
                const ProductDetailIcon(
                  icon: Icon(Icons.attach_money),
                  text: Text("weight"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
