// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'order_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductDto _$OrderProductDtoFromJson(Map<String, dynamic> json) =>
    OrderProductDto(
      orderId: json['orderId'] as int,
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
    );

Map<String, dynamic> _$OrderProductDtoToJson(OrderProductDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
