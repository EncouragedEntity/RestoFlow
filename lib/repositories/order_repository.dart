import 'dart:convert';

import 'package:resto_flow/models/order.dart';

import '../models/products/order_product_dto.dart';

class OrderRepository {
  static final OrderRepository _instance = OrderRepository._();
  List<OrderProductDto> _products = List.empty(growable: true);
  Order? currentOrder;

  factory OrderRepository() {
    return _instance;
  }

  OrderRepository._();

  List<OrderProductDto> get getProducts {
    _products.sort(
      (a, b) {
        return a.productId.compareTo(b.productId);
      },
    );

    return _products;
  }

  void addProductToOrder(OrderProductDto product) {
    _products.add(product);
  }

  void removeProductFromOrder(OrderProductDto product) {
    _products.remove(product);
  }

  void setProducts(List<OrderProductDto> newProducts) {
    _products = newProducts;
  }

  void addProducts(List<OrderProductDto> newProducts) {
    _products.addAll(newProducts);
  }

  List<OrderProductDto> parseOrderProductDtos(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    OrderRepository().currentOrder = Order.fromJson(jsonMap['orderDto']);
    final List<dynamic> jsonList = jsonMap['orderProductDtos'];
    return jsonList.map((json) => OrderProductDto.fromJson(json)).toList();
  }
}
