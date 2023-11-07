import 'package:flutter/material.dart';

class ProductDetailIcon extends StatelessWidget {
  const ProductDetailIcon({
    super.key,
    required this.icon,
    required this.text,
    this.boxHeight = 50,
  });

  final Icon icon;
  final Text text;
  final double boxHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          icon,
          const Spacer(),
          text,
        ],
      ),
    );
  }
}
