import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resto_flow/models/products/product_dtos_list.dart';

import '../models/order/order.dart';
import '../models/products/order_product_dto.dart';

class OrderRepository with ChangeNotifier {
  static final OrderRepository _instance = OrderRepository._();
  List<OrderProductDto> products = List.empty(growable: true);
  Order? currentOrder;

  ProductDtosList list = ProductDtosList();

  String? get orderStatus => currentOrder?.status;

  factory OrderRepository() {
    return _instance;
  }

  OrderRepository._() {
    notifyListeners();
  }

  @override
  notifyListeners() {
    super.notifyListeners();
  }

  List<OrderProductDto> get getProducts {
    products.sort(
      (a, b) {
        return a.productId.compareTo(b.productId);
      },
    );

    return products;
  }

  void addProductToOrder(OrderProductDto product) {
    products.add(product);
    list.notifyListeners();
  }

  void removeProductFromOrder(OrderProductDto product) {
    products.remove(product);
    list.notifyListeners();
  }

  void setProducts(List<OrderProductDto> newProducts) {
    products = newProducts;
    list.notifyListeners();
  }

  void addProducts(List<OrderProductDto> newProducts) {
    products.addAll(newProducts);
    list.notifyListeners();
  }

  List<OrderProductDto> parseOrderProductDtos(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    OrderRepository().currentOrder = Order.fromJson(jsonMap['orderDto']);
    final List<dynamic> jsonList = jsonMap['orderProductDtos'];
    return jsonList.map((json) => OrderProductDto.fromJson(json)).toList();
  }
}
