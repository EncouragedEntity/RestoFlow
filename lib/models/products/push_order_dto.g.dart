// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushOrderDto _$PushOrderDtoFromJson(Map<String, dynamic> json) => PushOrderDto(
      (json['orderProductDtos'] as List<dynamic>)
          .map((e) => SocketProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PushOrderDtoToJson(PushOrderDto instance) =>
    <String, dynamic>{
      'orderProductDtos': instance.orderProductDtos,
    };
