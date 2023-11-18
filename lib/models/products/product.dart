import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:resto_flow/models/products/image_dto.dart';
import 'package:resto_flow/models/products/measurement_unit.dart';
import 'package:resto_flow/repositories/measurement_unit_repository.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final double price;
  final int quantity;
  final int measurmentUnitId;
  final int restaurantId;
  final List<String> ingredients;
  final int cookingTime;
  final List<ImageDto>? images;

  MeasurementUnit get unit =>
      MeasurementUnitRepository().getById(measurmentUnitId);

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.quantity,
    required this.measurmentUnitId,
    required this.restaurantId,
    required this.ingredients,
    required this.cookingTime,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJsonMap() => _$ProductToJson(this);

  String toJsonString() => jsonEncode(toJsonMap());

  Product copyWith({
    int? id,
    String? name,
    String? description,
    int? categoryId,
    double? price,
    int? quantity,
    int? measurmentUnitId,
    int? restaurantId,
    List<String>? ingredients,
    int? cookingTime,
    List<ImageDto>? images,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      measurmentUnitId: measurmentUnitId ?? this.measurmentUnitId,
      restaurantId: restaurantId ?? this.restaurantId,
      ingredients: ingredients ?? this.ingredients,
      cookingTime: cookingTime ?? this.cookingTime,
      images: images ?? this.images,
    );
  }

  String get formattedPrice {
    if (price % 1 == 0) {
      return "${price.toStringAsFixed(0)} грн.";
    } else {
      return "${price.toStringAsFixed(2)} грн.";
    }
  }
}
