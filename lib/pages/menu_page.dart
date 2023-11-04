import 'package:flutter/material.dart';
import 'package:resto_flow/models/products/category.dart';
import 'package:resto_flow/models/products/product.dart';

import '../generated/l10n.dart';
import 'products/products_carousel_slider_page.dart';
import 'products/products_grid_view_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
    required this.categories,
    required this.products,
  });

  final List<ProductCategory> categories;
  final List<Product> products;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool productsDisplayModeGrid = false;
  late Icon displayModeIcon;

  late final List<ProductCategory> categories;
  late final List<Product> products;

  @override
  void initState() {
    super.initState();
    displayModeIcon = !productsDisplayModeGrid
        ? const Icon(Icons.grid_view_rounded)
        : const Icon(Icons.view_list_rounded);
    categories = widget.categories;
    products = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    if (categories.isNotEmpty) {
      return DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.menu_tab),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    productsDisplayModeGrid =
                        productsDisplayModeGrid ? false : true;
                    displayModeIcon = !productsDisplayModeGrid
                        ? const Icon(Icons.grid_view_rounded)
                        : const Icon(Icons.view_list_rounded);
                  });
                },
                icon: displayModeIcon,
              ),
            ],
            bottom: TabBar(
              indicatorColor: Theme.of(context).highlightColor,
              isScrollable: true,
              tabs: categories.map((category) {
                return Tab(
                  text: category.name,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: categories.map((category) {
              final categoryProducts = products
                  .where((element) => element.categoryId == category.id)
                  .toList();
              if (categoryProducts.isEmpty) {
                return const Center(
                  child: Text("Nothing here. For now ;)"),
                );
              }
              if (productsDisplayModeGrid == false) {
                return ProductsCarouselSliderPage(
                  categoryProducts: categoryProducts,
                  productsDisplayModeGrid: productsDisplayModeGrid,
                );
              } else {
                return ProductsGridViewPage(
                  categoryProducts: categoryProducts,
                  productsDisplayModeGrid: productsDisplayModeGrid,
                );
              }
            }).toList(),
          ),
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
