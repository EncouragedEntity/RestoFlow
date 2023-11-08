import 'package:resto_flow/models/order.dart';

import '../models/products/product.dart';

class OrderRepository {
  static final OrderRepository _instance = OrderRepository._();
  List<Product> _products = List.empty();
  late Order currentOrder;

  factory OrderRepository() {
    return _instance;
  }

  OrderRepository._();

  List<Product> get getProducts => _products;

  void addProductToOrder(Product product) {
    _products.add(product);
  }

  void removeProductFromOrder(Product product) {
    _products.remove(product);
  }

  void setProducts(List<Product> newProducts) {
    _products = newProducts;
  }
}
