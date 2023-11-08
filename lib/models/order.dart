import 'package:json_annotation/json_annotation.dart';

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

  Order({
    this.id,
    required this.tableId,
    this.sumToPay = 0,
    this.sumPaid = 0,
    this.tips = 0,
    this.restaurantId,
    this.done = false,
  });

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
  }) {
    return Order(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      sumToPay: sumToPay ?? this.sumToPay,
      sumPaid: sumPaid ?? this.sumPaid,
      tips: tips ?? this.tips,
      restaurantId: restaurantId ?? this.restaurantId,
      done: done ?? this.done,
    );
  }
}
