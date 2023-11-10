import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:resto_flow/models/products/socket_product.dart';

part 'push_order_dto.g.dart';

@JsonSerializable()
class PushOrderDto {
  final List<SocketProductData> orderProductDtos;

  PushOrderDto(this.orderProductDtos);

  Map<String, dynamic> toJson() => _$PushOrderDtoToJson(this);
  String toJsonString() => jsonEncode(toJson());

  factory PushOrderDto.fromJson(Map<String, dynamic> json) =>
      _$PushOrderDtoFromJson(json);
}
