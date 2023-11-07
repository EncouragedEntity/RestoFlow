import 'package:equatable/equatable.dart';
import 'package:resto_flow/models/products/product.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductShowAllEvent extends ProductEvent {
  final bool displayMode;
  final int selectedTab;

  ProductShowAllEvent({
    this.displayMode = false,
    this.selectedTab = 0,
  });
}

class ProductShowDetailsEvent extends ProductEvent {
  final Product product;

  ProductShowDetailsEvent(this.product);
  @override
  List<Object> get props => [product];
}

class ProductAddToOrderEvent extends ProductEvent {
  final Product product;

  ProductAddToOrderEvent(this.product);
  @override
  List<Object> get props => [product];
}
