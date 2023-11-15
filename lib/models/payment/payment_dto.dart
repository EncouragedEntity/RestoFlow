import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'payment_dto.g.dart';

@JsonSerializable()
class PaymentDto {
  final int orderId;
  final double amount;
  final String card;
  final String cardExpMonth;
  final String cardExpYear;
  final String cardCvv;

  PaymentDto({
    required this.orderId,
    required this.amount,
    required this.card,
    required this.cardExpMonth,
    required this.cardExpYear,
    required this.cardCvv,
  });

  Map<String, dynamic> toJson() => _$PaymentDtoToJson(this);
  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);
  String toJsonString() => jsonEncode(toJson());
}
