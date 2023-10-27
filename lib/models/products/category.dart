import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class ProductCategory {
  final int id;
  final String name;
  final int parentCategoryId;
  final int restaurantId;

  ProductCategory({
    required this.id,
    required this.name,
    required this.parentCategoryId,
    required this.restaurantId,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}
