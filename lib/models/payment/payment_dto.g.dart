// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => PaymentDto(
      orderId: json['orderId'] as int,
      amount: (json['amount'] as num).toDouble(),
      card: json['card'] as String,
      cardExpMonth: json['cardExpMonth'] as String,
      cardExpYear: json['cardExpYear'] as String,
      cardCvv: json['cardCvv'] as String,
    );

Map<String, dynamic> _$PaymentDtoToJson(PaymentDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'amount': instance.amount,
      'card': instance.card,
      'cardExpMonth': instance.cardExpMonth,
      'cardExpYear': instance.cardExpYear,
      'cardCvv': instance.cardCvv,
    };
