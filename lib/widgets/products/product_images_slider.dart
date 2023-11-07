import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/products/product.dart';

class ProductImagesSlider extends StatelessWidget {
  const ProductImagesSlider({
    super.key,
    required this.product,
    required this.width,
  });

  final Product product;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        padEnds: false,
        autoPlay: true,
        enableInfiniteScroll: false,
      ),
      items: product.images!.map((image) {
        return Builder(
          builder: (BuildContext ctx) {
            return Container(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              width: width,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: CachedNetworkImage(
                imageUrl: image.url,
                width: width,
                fit: BoxFit.fitWidth,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
