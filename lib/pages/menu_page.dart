import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_flow/blocs/events/product_event.dart';
import 'package:resto_flow/blocs/product_bloc.dart';
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
    this.productsDisplayModeGrid,
    this.selectedTab,
  });

  final List<ProductCategory> categories;
  final List<Product> products;

  final bool? productsDisplayModeGrid;
  final int? selectedTab;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  bool productsDisplayModeGrid = false;
  late Icon displayModeIcon;

  late final TabController _tabController;
  int selectedTab = 0;

  late final List<ProductCategory> categories;
  late final List<Product> products;

  @override
  void initState() {
    super.initState();
    productsDisplayModeGrid = widget.productsDisplayModeGrid ?? false;
    selectedTab = widget.selectedTab ?? 0;

    displayModeIcon = !productsDisplayModeGrid
        ? const Icon(Icons.grid_view_rounded)
        : const Icon(Icons.view_list_rounded);
    categories = widget.categories;
    products = widget.products;

    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: selectedTab,
    );

    _tabController.addListener(() {
      selectedTab = _tabController.index;
    });
  }

  Future<void> _handleRefresh() async {
    context.read<ProductBloc>().add(ProductShowAllEvent(
          displayMode: productsDisplayModeGrid,
          selectedTab: _tabController.index,
        ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: categories.length,
        child: RefreshIndicator(
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withGreen(70),
          color: Theme.of(context).highlightColor,
          onRefresh: _handleRefresh,
          child: Scaffold(
            appBar: AppBar(
              title: Text(S.current.menu_tab),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      productsDisplayModeGrid = !productsDisplayModeGrid;
                      displayModeIcon = !productsDisplayModeGrid
                          ? const Icon(Icons.grid_view_rounded)
                          : const Icon(Icons.view_list_rounded);
                      context.read<ProductBloc>().add(ProductShowAllEvent(
                            products: products,
                            categories: categories,
                            displayMode: productsDisplayModeGrid,
                            selectedTab: selectedTab,
                          ));
                    });
                  },
                  icon: displayModeIcon,
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).highlightColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: categories.map((category) {
                  return Tab(
                    text: category.name,
                  );
                }).toList(),
              ),
            ),
            body: ScrollConfiguration(
              behavior: const MaterialScrollBehavior(),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      children: categories.map((category) {
                        final categoryProducts = products
                            .where(
                                (element) => element.categoryId == category.id)
                            .toList();
                        if (categoryProducts.isEmpty) {
                          return Center(
                            child: Text(S.current.no_dishes),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
