import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'card_details.g.dart';

@JsonSerializable()
class CardDetails {
  final String digits;
  final String cvv;
  final String expMonth;
  final String expYear;

  CardDetails({
    required this.digits,
    required this.cvv,
    required this.expMonth,
    required this.expYear,
  });

  Map<String, dynamic> toJson() => _$CardDetailsToJson(this);
  factory CardDetails.fromJson(Map<String, dynamic> json) =>
      _$CardDetailsFromJson(json);

  String toJsonString() => jsonEncode(toJson());
}
