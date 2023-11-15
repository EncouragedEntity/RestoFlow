import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:resto_flow/models/order/order.dart';
import 'package:resto_flow/models/order/order_user_dto.dart';
import 'package:resto_flow/models/products/order_product_dto.dart';

part 'order_history_response_dto.g.dart';

@JsonSerializable()
class OrderHistoryResponseDto {
  Order orderDto;
  List<OrderProductDto> orderProductDtos;
  OrderUserDto orderUserDto;

  OrderHistoryResponseDto({
    required this.orderDto,
    required this.orderProductDtos,
    required this.orderUserDto,
  });

  Map<String, dynamic> toJson() => _$OrderHistoryResponseDtoToJson(this);

  factory OrderHistoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryResponseDtoFromJson(json);

  String toJsonString() => jsonEncode(toJson());
}
