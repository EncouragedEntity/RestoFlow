// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Table _$TableFromJson(Map<String, dynamic> json) => Table(
      id: json['id'] as String,
      name: json['name'] as String,
      statusId: json['statusId'] as String,
      numOfSeats: json['numOfSeats'] as int,
      restaurantId: json['restaurantId'] as int,
    );

Map<String, dynamic> _$TableToJson(Table instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'statusId': instance.statusId,
      'numOfSeats': instance.numOfSeats,
      'restaurantId': instance.restaurantId,
    };
