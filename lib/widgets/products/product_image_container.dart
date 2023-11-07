import 'package:flutter/material.dart';
import 'package:resto_flow/models/products/product.dart';
import 'package:resto_flow/widgets/products/product_single_image.dart';
import 'package:resto_flow/widgets/products/product_images_slider.dart';

class ProductImageContainer extends StatelessWidget {
  const ProductImageContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if ((product.images?.length ?? 0) > 1) {
      return ProductImagesSlider(
        product: product,
        width: width,
      );
    }

    if ((product.images?.length ?? 0) == 1) {
      return ProductSingleImage(
        width: width,
        product: product,
      );
    }

    return Image.network(
      'https://placehold.co/200x200/png',
      height: 200,
    );
  }
}
