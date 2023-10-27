// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as int,
      price: (json['price'] as num).toDouble(),
      measurmentUnitId: json['measurmentUnitId'] as int,
      restaurantId: json['restaurantId'] as int,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'measurmentUnitId': instance.measurmentUnitId,
      'restaurantId': instance.restaurantId,
    };
