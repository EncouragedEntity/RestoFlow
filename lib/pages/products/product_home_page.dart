import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/nav_event.dart';
import 'package:resto_flow/blocs/nav_bloc.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/pages/menu_page.dart';
import 'package:resto_flow/widgets/my_themed_button.dart';

import 'product_details_page.dart';

class ProductHomePage extends StatefulWidget {
  const ProductHomePage({super.key, required this.appBarKey});
  @override
  State<ProductHomePage> createState() => _ProductHomePageState();

  final GlobalKey<ConvexAppBarState> appBarKey;
}

class _ProductHomePageState extends State<ProductHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (orderCtx, state) {
        if (state is OrderTableSetState && state.tableId.isNotEmpty) {
          return BlocBuilder<ProductBloc, ProductState>(
            builder: (productCtx, state) {
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
        return Center(
            child: Container(
          constraints: const BoxConstraints(
            maxWidth: 250,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("You should scan qr first"),
              MyThemedButton(
                // TODO change texts
                onPressed: () {
                  context.read<NavBloc>().add(NavEvent.scanner);
                  widget.appBarKey.currentState?.animateTo(2);
                },
                child: const Text("Go to scan page"),
              ),
            ],
          ),
        ));
      },
    );
  }
}
