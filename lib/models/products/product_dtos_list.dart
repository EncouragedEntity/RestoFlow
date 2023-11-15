import 'package:flutter/material.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';
import 'package:resto_flow/repositories/order_repository.dart';

class ProductDtosList with ChangeNotifier {
  static final ProductDtosList _instance = ProductDtosList._internal();

  factory ProductDtosList() {
    return _instance;
  }

  ProductDtosList._internal();

  List<OrderProductDto> get productDtos => OrderRepository().getProducts;

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
