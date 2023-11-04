import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/models/products/product.dart';

//TODO
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: IconButton(
          onPressed: () {
            context.read<ProductBloc>().add(ProductShowAllEvent());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
