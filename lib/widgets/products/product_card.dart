import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
import 'package:resto_flow/models/products/measurement_unit.dart';
import 'package:resto_flow/repositories/measurement_unit_repository.dart';
import 'package:resto_flow/widgets/products/product_detail_icon.dart';

import '../../generated/l10n.dart';
import '../../models/products/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.displayMode,
  });

  final bool displayMode;

  final Product product;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late final MeasurementUnit unit;

  @override
  void initState() {
    super.initState();
    unit = MeasurementUnitRepository().getById(widget.product.measurmentUnitId);
  }

  @override
  Widget build(BuildContext context) {
    String productName = widget.product.name.length > 13
        ? "${widget.product.name.substring(0, 13)}..."
        : widget.product.name;

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
                        .add(ProductAddToOrderEvent(widget.product));
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(Icons.add),
                  title: Text(S.current.add_to_order),
                ),
                ListTile(
                  onTap: () {
                    context
                        .read<ProductBloc>()
                        .add(ProductShowDetailsEvent(widget.product));
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
        context
            .read<ProductBloc>()
            .add(ProductShowDetailsEvent(widget.product));
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
              height: !widget.displayMode ? 10 : 4,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: widget.product.images?[0].url ??
                    'https://placehold.co/200x200/png',
                height: !widget.displayMode ? 200 : 100,
                width: !widget.displayMode ? 200 : 100,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              productName,
              style: TextStyle(fontSize: !widget.displayMode ? 20 : 14),
            ),
            SizedBox(height: !widget.displayMode ? 20 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.displayMode)
                  ProductDetailIcon(
                    icon: const Icon(Icons.scale, size: 24),
                    text: Text(
                      "${widget.product.quantity} ${unit.abbreviation}",
                      style: TextStyle(fontSize: !widget.displayMode ? 16 : 14),
                    ),
                  ),
                ProductDetailIcon(
                  icon: Icon(Icons.attach_money,
                      size: !widget.displayMode ? 24 : 18),
                  text: Text(
                    "${widget.product.price.toStringAsFixed(2)} грн.",
                    style: TextStyle(fontSize: !widget.displayMode ? 16 : 14),
                  ),
                  boxHeight: !widget.displayMode ? 50 : 34,
                ),
                ProductDetailIcon(
                  icon: Icon(Icons.access_time,
                      size: !widget.displayMode ? 24 : 18),
                  text: Text(
                    "${widget.product.cookingTime} хв.",
                    style: TextStyle(fontSize: !widget.displayMode ? 16 : 14),
                  ),
                  boxHeight: !widget.displayMode ? 50 : 34,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
