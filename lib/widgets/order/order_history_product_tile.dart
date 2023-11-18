import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/models/products/product.dart';
import 'package:resto_flow/pages/products/product_details_page.dart';
import 'package:resto_flow/repositories/product_repository.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:skeletons/skeletons.dart';

import '../../blocs/events/order_event.dart';
import '../../blocs/order_bloc.dart';

class OrderHistoryProductListTile extends StatefulWidget {
  const OrderHistoryProductListTile(
    this.productDto, {
    super.key,
  });
  final OrderProductDto productDto;
  @override
  State<OrderHistoryProductListTile> createState() =>
      _OrderProductListTileState();
}

class _OrderProductListTileState extends State<OrderHistoryProductListTile> {
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "x${widget.productDto.quantity}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(" / ${product.formattedPrice}",
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
