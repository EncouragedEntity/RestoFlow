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
      quantity: json['quantity'] as int,
      measurmentUnitId: json['measurmentUnitId'] as int,
      restaurantId: json['restaurantId'] as int,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      cookingTime: json['cookingTime'] as int,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'quantity': instance.quantity,
      'measurmentUnitId': instance.measurmentUnitId,
      'restaurantId': instance.restaurantId,
      'ingredients': instance.ingredients,
      'cookingTime': instance.cookingTime,
      'images': instance.images,
    };
