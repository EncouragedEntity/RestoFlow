// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      tableId: json['tableId'] as String,
      sumToPay: (json['sumToPay'] as num?)?.toDouble() ?? 0,
      sumPaid: (json['sumPaid'] as num?)?.toDouble() ?? 0,
      tips: (json['tips'] as num?)?.toDouble() ?? 0,
      restaurantId: json['restaurantId'] as int?,
      done: json['done'] as bool? ?? false,
      status: json['status'] as String? ?? orderStatusChoosing,
    )..createdDate = json['createdDate'] as String?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'tableId': instance.tableId,
      'sumToPay': instance.sumToPay,
      'sumPaid': instance.sumPaid,
      'tips': instance.tips,
      'restaurantId': instance.restaurantId,
      'done': instance.done,
      'status': instance.status,
      'createdDate': instance.createdDate,
    };
