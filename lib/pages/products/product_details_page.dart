import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/models/products/product.dart';

//TODO
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final productState = context.read<ProductBloc>().state;
    if (productState is ProductDetailsState) {
      return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          leading: IconButton(
            onPressed: () {
              context.read<ProductBloc>().add(ProductShowAllEvent(
                    displayMode: productState.displayMode,
                    selectedTab: productState.selectedTab,
                  ));
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      );
    }
    return const Placeholder(); //TODO show error
  }
}
