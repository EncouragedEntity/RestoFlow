import 'package:flutter/material.dart';

import '../../models/products/product.dart';
import '../../widgets/products/product_card.dart';

class ProductsGridViewPage extends StatelessWidget {
  const ProductsGridViewPage({
    super.key,
    required this.categoryProducts,
    required this.productsDisplayModeGrid,
  });

  final List<Product> categoryProducts;
  final bool productsDisplayModeGrid;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 24.0,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: categoryProducts.length,
      itemBuilder: (context, index) {
        final product = categoryProducts[index];
        final finalProduct = product.copyWith(name: product.name);
        return ProductCard(
          product: finalProduct,
          displayMode: productsDisplayModeGrid,
        );
      },
    );
  }
}
