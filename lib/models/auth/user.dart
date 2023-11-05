import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> authorities;
  final int bonusScore;
  final bool deleted;
  final String? password;
  final String? restaurantAddress;
  final int? restaurantId;
  final String? restaurantName;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.authorities,
    this.bonusScore = 0,
    this.deleted = false,
    required this.password,
    this.restaurantAddress,
    this.restaurantId,
    this.restaurantName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJsonMap() => _$UserToJson(this);
  String toJsonString() => jsonEncode(toJsonMap());

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    List<String>? authorities,
    int? bonusScore,
    bool? deleted,
    String? password,
    String? restaurantAddress,
    int? restaurantId,
    String? restaurantName,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      authorities: authorities ?? this.authorities,
      bonusScore: bonusScore ?? this.bonusScore,
      deleted: deleted ?? this.deleted,
      password: password,
      restaurantAddress: restaurantAddress ?? this.restaurantAddress,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
    );
  }
}
