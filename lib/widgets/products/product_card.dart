import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/widgets/products/product_detail_icon.dart';

import '../../generated/l10n.dart';
import '../../models/products/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.displayMode,
  });

  final bool displayMode;

  final Product product;

  @override
  Widget build(BuildContext context) {
    String productName = product.name.length > 13
        ? "${product.name.substring(0, 13)}..."
        : product.name;

    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          useSafeArea: true,
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withRed(100),
          context: context,
          builder: (ctx) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    context
                        .read<ProductBloc>()
                        .add(ProductAddToOrderEvent(product));
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(Icons.add),
                  title: Text(S.current.add_to_order),
                ),
                ListTile(
                  onTap: () {
                    context
                        .read<ProductBloc>()
                        .add(ProductShowDetailsEvent(product));
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(Icons.more_vert),
                  title: Text(S.current.details),
                ),
              ],
            );
          },
        );
      },
      onLongPress: () {
        context.read<ProductBloc>().add(ProductShowDetailsEvent(product));
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      splashColor: Colors.white.withAlpha(50),
      highlightColor: Colors.white.withAlpha(50),
      child: Card(
        color: Theme.of(context).primaryColor.withAlpha(100),
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  product.images?[0].url ?? 'https://placehold.co/200x200/png',
              height: !displayMode ? 200 : 100,
              width: 200,
            ),
            SizedBox(height: !displayMode ? 30 : 10),
            Text(productName),
            SizedBox(height: !displayMode ? 32 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProductDetailIcon(
                  icon: Icon(Icons.attach_money, size: !displayMode ? 24 : 20),
                  text: Text("${product.price.toStringAsFixed(2)} грн."),
                ),
                !displayMode
                    ? ProductDetailIcon(
                        icon: const Icon(Icons.scale),
                        text: Text("${product.quantity} гр."),
                      )
                    : Container(),
                ProductDetailIcon(
                  icon: const Icon(Icons.access_time, size: 20),
                  text: Text("${product.cookingTime} хв."),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
