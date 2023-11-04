import 'package:equatable/equatable.dart';
import 'package:resto_flow/models/products/product.dart';

import '../../models/products/category.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductAllState extends ProductState {
  final List<ProductCategory> categories;
  final List<Product> products;

  ProductAllState(this.categories, this.products);

  @override
  List<Object> get props => [
        categories,
        products,
      ];
}

class ProductFailureState extends ProductState {
  final String errorMessage;

  ProductFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ProductDetailsState extends ProductState {
  final Product product;

  ProductDetailsState(this.product);

  @override
  List<Object> get props => [product];
}
