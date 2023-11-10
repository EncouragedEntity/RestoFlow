import 'package:json_annotation/json_annotation.dart';

part 'order_product_dto.g.dart';

@JsonSerializable()
class OrderProductDto {
  final int orderId;
  final int productId;
  final int quantity;
  final String status;

  OrderProductDto({
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.status,
  });

  factory OrderProductDto.fromJson(Map<String, dynamic> json) =>
      _$OrderProductDtoFromJson(json);
}
