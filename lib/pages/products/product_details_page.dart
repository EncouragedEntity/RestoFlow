import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/order_event.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/blocs/states/product_state.dart';
import 'package:resto_flow/models/products/product.dart';
import 'package:resto_flow/widgets/my_themed_button.dart';

import '../../generated/l10n.dart';
import '../../widgets/app_bar_logo.dart';
import '../../widgets/products/product_image_container.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppBarLogo(),
          leading: IconButton(
            onPressed: () {
              final productState = context.read<ProductBloc>().state;
              if (productState is ProductDetailsState) {
                context.read<ProductBloc>().add(ProductShowAllEvent(
                      displayMode: productState.displayMode,
                      selectedTab: productState.selectedTab,
                    ));
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProductImageContainer(
                product: product,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: screenWidth / 2),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 32,
                            ),
                          ),
                        ),
                        Text(
                          "${product.formattedPrice}/${product.quantity}${product.unit.abbreviation}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${product.ingredients.map((e) => e)}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Час приготування: ${product.cookingTime} хв.",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withAlpha(120),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MyThemedButton(
                      height: 50,
                      onPressed: () {
                        context.read<OrderBloc>().add(
                              OrderAddProductEvent(product),
                            );
                      },
                      child: Text(S.current.add_to_order),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
