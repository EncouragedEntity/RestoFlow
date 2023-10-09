import 'dart:convert';

class User {
  final int? id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> authorities;
  final int bonusScore;
  final bool deleted;
  final String password;
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      authorities: List<String>.from(json['authorities']),
      bonusScore: json['bonusScore'] as int? ?? 0,
      deleted: json['deleted'] as bool? ?? false,
      password: json['password'] as String,
      restaurantAddress: json['restaurantAddress'] as String,
      restaurantId: json['restaurantId'] as int,
      restaurantName: json['restaurantName'] as String,
    );
  }

  String toJson() {
    return jsonEncode(toJsonMap());
  }

  Map<String, dynamic> toJsonMap() {
    return {
      'id': id ?? "0",
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'authorities': authorities,
      'bonusScore': bonusScore,
      'deleted': deleted,
      'password': password,
      'restaurantAddress': null,
      'restaurantId': null,
      'restaurantName': null,
    };
  }
}
