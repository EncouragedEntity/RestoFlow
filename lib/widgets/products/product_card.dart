import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/order_event.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/order_bloc.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/widgets/products/product_detail_icon.dart';

import '../../blocs/states/product_state.dart';
import '../../generated/l10n.dart';
import '../../models/products/product.dart';
import '../../pages/products/product_details_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late final bool displayMode;
  late final int selectedTab;

  @override
  void initState() {
    super.initState();
    final productState = context.read<ProductBloc>().state;
    if (productState is ProductAllState) {
      displayMode = productState.displayMode;
      selectedTab = productState.selectedTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    String productName = widget.product.name.length > 13
        ? "${widget.product.name.substring(0, 13)}..."
        : widget.product.name;
    String productImageUrl = 'https://placehold.co/200x200/png';

    if (widget.product.images?.isNotEmpty ?? false) {
      productImageUrl = widget.product.images![0].url;
    }

    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          useSafeArea: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          context: context,
          builder: (ctx) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    context
                        .read<OrderBloc>()
                        .add(OrderAddProductEvent(widget.product));
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(Icons.add),
                  title: Text(S.current.add_to_order),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return ProductDetailsPage(
                            product: widget.product,
                            allowToAdd: true,
                          );
                        },
                      ),
                    ).then(
                      (value) {
                        if (value == true) {
                          context
                              .read<OrderBloc>()
                              .add(OrderAddProductEvent(widget.product));
                        }
                      },
                    );
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
        context.read<ProductBloc>().add(ProductShowDetailsEvent(
              widget.product,
              displayMode,
              selectedTab,
            ));
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
            SizedBox(
              height: !displayMode ? 10 : 4,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: productImageUrl,
                height: !displayMode ? 200 : 100,
                width: !displayMode ? 200 : 100,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              productName,
              style: TextStyle(fontSize: !displayMode ? 20 : 14),
            ),
            SizedBox(height: !displayMode ? 20 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!displayMode)
                  ProductDetailIcon(
                    icon: const Icon(Icons.scale, size: 24),
                    text: Text(
                      "${widget.product.quantity} ${widget.product.unit.abbreviation}",
                      style: TextStyle(fontSize: !displayMode ? 16 : 14),
                    ),
                  ),
                ProductDetailIcon(
                  icon: Icon(Icons.attach_money, size: !displayMode ? 24 : 18),
                  text: Text(
                    widget.product.formattedPrice,
                    style: TextStyle(fontSize: !displayMode ? 16 : 14),
                  ),
                  boxHeight: !displayMode ? 50 : 34,
                ),
                ProductDetailIcon(
                  icon: Icon(Icons.access_time, size: !displayMode ? 24 : 18),
                  text: Text(
                    "${widget.product.cookingTime} хв.",
                    style: TextStyle(fontSize: !displayMode ? 16 : 14),
                  ),
                  boxHeight: !displayMode ? 50 : 34,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
