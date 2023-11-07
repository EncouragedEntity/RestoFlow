import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/products/product.dart';

class ProductSingleImage extends StatelessWidget {
  const ProductSingleImage({
    super.key,
    required this.width,
    required this.product,
  });

  final double width;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 300,
      ),
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: CachedNetworkImage(
        imageUrl: product.images![0].url,
        alignment: Alignment.topCenter,
        width: width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
