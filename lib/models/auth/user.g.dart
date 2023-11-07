// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      authorities: (json['authorities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      bonusScore: json['bonusScore'] as int? ?? 0,
      deleted: json['deleted'] as bool? ?? false,
      password: json['password'] as String?,
      restaurantAddress: json['restaurantAddress'] as String?,
      restaurantId: json['restaurantId'] as int?,
      restaurantName: json['restaurantName'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'authorities': instance.authorities,
      'bonusScore': instance.bonusScore,
      'deleted': instance.deleted,
      'password': instance.password,
      'restaurantAddress': instance.restaurantAddress,
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
    };
