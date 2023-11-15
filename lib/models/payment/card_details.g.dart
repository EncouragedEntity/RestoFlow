// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDetails _$CardDetailsFromJson(Map<String, dynamic> json) => CardDetails(
      digits: json['digits'] as String,
      cvv: json['cvv'] as String,
      expMonth: json['expMonth'] as String,
      expYear: json['expYear'] as String,
    );

Map<String, dynamic> _$CardDetailsToJson(CardDetails instance) =>
    <String, dynamic>{
      'digits': instance.digits,
      'cvv': instance.cvv,
      'expMonth': instance.expMonth,
      'expYear': instance.expYear,
    };
