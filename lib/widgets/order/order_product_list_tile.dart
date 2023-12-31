import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/models/products/product.dart';
import 'package:resto_flow/pages/products/product_details_page.dart';
import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/repositories/product_repository.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:skeletons/skeletons.dart';

import '../../blocs/events/order_event.dart';
import '../../blocs/order_bloc.dart';
import '../../data/string_constants.dart';

class OrderProductListTile extends StatefulWidget {
  const OrderProductListTile(
    this.productDto, {
    super.key,
    this.onInscrease,
    this.onDecrease,
    this.onDelete,
  });
  final OrderProductDto productDto;

  final void Function(Product product)? onInscrease;
  final void Function(Product product)? onDecrease;
  final void Function(Product product)? onDelete;

  @override
  State<OrderProductListTile> createState() => _OrderProductListTileState();
}

class _OrderProductListTileState extends State<OrderProductListTile> {
  late Future<Product> productFuture;

  @override
  void initState() {
    super.initState();
    productFuture = setProduct();
  }

  Future<Product> setProduct() async {
    return ProductRepository(
      hostname: UserRepository.instance!.hostname!,
    ).getById(
      widget.productDto.productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SkeletonItem(
            child: SkeletonListTile(
              leadingStyle: const SkeletonAvatarStyle(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        } else {
          final Product product = snapshot.data!;
          final status =
              OrderRepository().currentOrder?.status ?? orderStatusChoosing;

          final bool isOrderStatusChoosing = status == orderStatusChoosing;

          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailsPage(
                      product: product,
                      allowToAdd: false,
                    );
                  },
                ),
              ).then(
                (value) async {
                  if (value == true) {
                    context
                        .read<OrderBloc>()
                        .add(OrderAddProductEvent(product));
                  }
                },
              );
            },
            leading: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 50,
                child: CachedNetworkImage(
                  imageUrl: product.images![0].url,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            title: Text(
              product.name,
              style: const TextStyle(fontSize: 18),
            ),
            trailing: SizedBox(
              width: 170,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: isOrderStatusChoosing
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  if (isOrderStatusChoosing && widget.onDecrease != null)
                    IconButton.filled(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).buttonTheme.colorScheme?.background,
                      )),
                      onPressed: () {
                        widget.onDecrease!(product);
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  Text(
                    "x${widget.productDto.quantity}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (!isOrderStatusChoosing)
                    Text(" / ${product.formattedPrice}",
                        style: const TextStyle(fontSize: 16)),
                  if (isOrderStatusChoosing && widget.onInscrease != null)
                    IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).buttonTheme.colorScheme?.background,
                        ),
                      ),
                      onPressed: () {
                        widget.onInscrease!(product);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  if (isOrderStatusChoosing) const Spacer(),
                  if (isOrderStatusChoosing && widget.onDecrease != null)
                    IconButton.filled(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).buttonTheme.colorScheme?.background,
                      )),
                      onPressed: () {
                        widget.onDelete!(product);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
