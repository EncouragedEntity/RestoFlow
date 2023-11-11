import 'package:flutter/material.dart';
import 'package:resto_flow/models/products/product.dart';
import 'package:resto_flow/widgets/my_themed_button.dart';

import '../../generated/l10n.dart';
import '../../widgets/products/product_image_container.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.allowToAdd,
  });

  final Product product;
  final bool allowToAdd;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                    if (allowToAdd)
                      MyThemedButton(
                        height: 50,
                        onPressed: () {
                          Navigator.of(context).pop<bool>(true);
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
