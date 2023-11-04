import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/products/product.dart';
import '../../widgets/products/product_card.dart';

class ProductsCarouselSliderPage extends StatelessWidget {
  const ProductsCarouselSliderPage({
    super.key,
    required this.categoryProducts,
    required this.productsDisplayModeGrid,
  });

  final List<Product> categoryProducts;
  final bool productsDisplayModeGrid;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        height: 350,
        enlargeFactor: 0.15,
      ),
      items: categoryProducts.map(
        (product) {
          final finalProduct = product.copyWith(name: product.name);
          return ProductCard(
            product: finalProduct,
            displayMode: productsDisplayModeGrid,
          );
        },
      ).toList(),
    );
  }
}
