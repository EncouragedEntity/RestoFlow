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

  factory OrderUserDto.fromJson(Map<String, dynamic> json) {
    return OrderUserDto(
      orderId: json['orderId'],
      userId: json['userId'],
      sumPaid: json['sumPaid'].toDouble(),
    );
  }
}
