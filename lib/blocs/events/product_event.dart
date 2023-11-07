import 'package:equatable/equatable.dart';
import 'package:resto_flow/models/products/product.dart';

import '../../models/products/category.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductShowAllEvent extends ProductEvent {
  final List<ProductCategory>? categories;
  final List<Product>? products;
  final bool displayMode;
  final int selectedTab;

  ProductShowAllEvent({
    this.categories,
    this.products,
    this.displayMode = false,
    this.selectedTab = 0,
  });
}

class ProductShowDetailsEvent extends ProductEvent {
  final Product product;
  final bool displayMode;
  final int selectedTab;

  ProductShowDetailsEvent(this.product, this.displayMode, this.selectedTab);
  @override
  List<Object> get props => [
        product,
        displayMode,
        selectedTab,
      ];
}

class ProductAddToOrderEvent extends ProductEvent {
  final Product product;

  ProductAddToOrderEvent(this.product);
  @override
  List<Object> get props => [product];
}
