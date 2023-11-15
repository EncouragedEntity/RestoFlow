// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'order_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUserDto _$OrderUserDtoFromJson(Map<String, dynamic> json) => OrderUserDto(
      orderId: json['orderId'] as int,
      userId: json['userId'] as int,
      sumPaid: (json['sumPaid'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderUserDtoToJson(OrderUserDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'userId': instance.userId,
      'sumPaid': instance.sumPaid,
    };
