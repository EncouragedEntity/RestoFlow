// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryResponseDto _$OrderHistoryResponseDtoFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryResponseDto(
      orderDto: Order.fromJson(json['orderDto'] as Map<String, dynamic>),
      orderProductDtos: (json['orderProductDtos'] as List<dynamic>)
          .map((e) => OrderProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderUserDto:
          OrderUserDto.fromJson(json['orderUserDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderHistoryResponseDtoToJson(
        OrderHistoryResponseDto instance) =>
    <String, dynamic>{
      'orderDto': instance.orderDto,
      'orderProductDtos': instance.orderProductDtos,
      'orderUserDto': instance.orderUserDto,
    };
