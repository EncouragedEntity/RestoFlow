import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/pages/menu_page.dart';

import 'product_details_page.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key});

  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (ctx, state) {
        if (state is ProductAllState) {
          return MenuPage(
            categories: state.categories,
            products: state.products,
            productsDisplayModeGrid: state.displayMode,
            selectedTab: state.selectedTab,
          );
        }
        if (state is ProductDetailsState) {
          return ProductDetailsPage(
            product: state.product,
          );
        }
        if (state is ProductLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        return const Placeholder(); // TODO show error
      },
    );
  }
}
