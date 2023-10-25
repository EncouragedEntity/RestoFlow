import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final double price;
  final int measurmentUnitId;
  final int restaurantId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.measurmentUnitId,
    required this.restaurantId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJsonMap() => _$ProductToJson(this);

  String toJsonString() => jsonEncode(toJsonMap());
}
