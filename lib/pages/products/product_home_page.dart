import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/blocs/states/order_state.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/pages/menu_page.dart';

import '../../generated/l10n.dart';
import '../../widgets/page_blocker.dart';
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
        return PageBlocker(
          appBarKey: widget.appBarKey,
          destinationIndex: 2,
          text: S.current.scan_first,
          buttonText: S.current.go_to_scan,
        );
      },
    );
  }
}
