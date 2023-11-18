import 'package:json_annotation/json_annotation.dart';

part 'order_user_dto.g.dart';

@JsonSerializable()
class OrderUserDto {
  int orderId;
  int userId;
  double sumPaid;

  OrderUserDto({
    required this.orderId,
    required this.userId,
    required this.sumPaid,
  });

  factory OrderUserDto.fromJson(Map<String, dynamic> json) =>
      _$OrderUserDtoFromJson(json);

  String get formattedSumPaid {
    if (sumPaid % 1 == 0) {
      return sumPaid.toStringAsFixed(0);
    } else {
      return sumPaid.toStringAsFixed(2);
    }
  }
}
