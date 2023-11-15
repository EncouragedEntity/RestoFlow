import 'package:json_annotation/json_annotation.dart';
import 'package:resto_flow/data/string_constants.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int? id;
  final String tableId;
  double sumToPay;
  final double sumPaid;
  double tips;
  final int? restaurantId;
  bool done = false;
  String status;

  Order({
    this.id,
    required this.tableId,
    this.sumToPay = 0,
    this.sumPaid = 0,
    this.tips = 0,
    this.restaurantId,
    this.done = false,
    this.status = orderStatusChoosing,
  });

  String get formattedSumToPay {
    if (sumToPay % 1 == 0) {
      return sumToPay.toStringAsFixed(0);
    } else {
      return sumToPay.toStringAsFixed(2);
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
  Order copyWith({
    int? id,
    String? tableId,
    double? sumToPay,
    double? sumPaid,
    double? tips,
    int? restaurantId,
    bool? done,
    String? status,
  }) {
    return Order(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      sumToPay: sumToPay ?? this.sumToPay,
      sumPaid: sumPaid ?? this.sumPaid,
      tips: tips ?? this.tips,
      restaurantId: restaurantId ?? this.restaurantId,
      done: done ?? this.done,
      status: status ?? this.status,
    );
  }
}
