import 'package:flutter/material.dart';

class ProductDetailIcon extends StatelessWidget {
  const ProductDetailIcon({super.key, required this.icon, required this.text});

  final Icon icon;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          icon,
          text,
        ],
      ),
    );
  }
}
