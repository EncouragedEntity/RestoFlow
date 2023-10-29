import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:resto_flow/data/data_mocker.dart';
import 'package:resto_flow/models/products/category.dart';
import 'package:resto_flow/models/products/product.dart';
import 'package:resto_flow/widgets/products/product_card.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<ProductCategory> categories = List.empty();
  List<Product> products = List.empty();
  // ignore: unused_field
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> getCategories() async {
    categories = await DataMocker().getCategories();
  }

  Future<void> getProducts() async {
    products = await DataMocker().getProducts();
  }

  Future<void> getMenu() async {
    await getCategories();
    await getProducts();
  }

  // ignore: unused_element
  Future<void> _refresh() async {
    await getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMenu(),
      builder: (context, snapshot) {
        if (categories.isNotEmpty) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: <Widget>[
                  ...categories.map((category) {
                    final categoryProducts = products
                        .where((element) => element.categoryId == category.id)
                        .toList();

                    return SliverStickyHeader(
                      header: Container(
                        height: 50.0,
                        color: Theme.of(context).primaryColor,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      sliver: SliverToBoxAdapter(
                        child: SizedBox(
                          height: 350,

                          child: CarouselSlider(
                            options: CarouselOptions(
                              animateToClosest: true,
                              reverse: false,
                              enableInfiniteScroll: false,
                              initialPage: 0,
                              height: 350,
                              padEnds: false,
                            ),
                            items: categoryProducts.map(
                              (e) {
                                final product = e;
                                return ProductCard(product: product);
                              },
                            ).toList(),
                          ),
                          // child: ListView.builder(
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: categoryProducts.length,
                          //   itemBuilder: (context, index) {
                          //
                          //   },
                          // ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
