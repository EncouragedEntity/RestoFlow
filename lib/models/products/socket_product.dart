import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'socket_product.g.dart';

@JsonSerializable()
class SocketProductData {
  final int productId;
  final int quantity;

  SocketProductData(this.productId, this.quantity);

  Map<String, dynamic> toJson() => _$SocketProductDataToJson(this);
  String toJsonString() => jsonEncode(toJson());

  factory SocketProductData.fromJson(Map<String, dynamic> json) =>
      _$SocketProductDataFromJson(json);
}
