import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:resto_flow/data/constants.dart';
import 'package:resto_flow/models/auth/auth_response_dto.dart';
import 'package:resto_flow/models/auth/user.dart';

class UserRepository {
  final String? hostname;
  static UserRepository? instance;
  static User? currentUser;

  factory UserRepository({required String apiUrl}) {
    instance ??= UserRepository._internal(hostname: apiUrl);
    return instance!;
  }

  UserRepository._internal({required this.hostname});

  Future<User> logIn(String email, String password) async {
    final response = await http.post(
      Uri.parse(hostname! + authLoginUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final AuthResponseDto responseDto = AuthResponseDto.fromJson(data);
      currentUser = responseDto.userDTO;

      const storage = FlutterSecureStorage();

      storage.write(
        key: "accessToken",
        value: responseDto.authTokenDTO.accessToken,
      );
      return currentUser!;
    } else {
      throw Exception('Failed to sign in: ${response.reasonPhrase}');
    }
  }

  Future<User> register(String email, String password) async {
    final user = User(
      username: email,
      email: email,
      firstName: "",
      lastName: "",
      authorities: ["USER"],
      password: password,
    );

    final userJson = user.toJson();

    final response = await http.post(
      Uri.parse(hostname! + authRegisterUrl),
      body: userJson,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      currentUser = User.fromJson(data);
      return currentUser!;
    } else {
      throw Exception('Failed to sign up: ${response.reasonPhrase}');
    }
  }

  Future<void> signOut() async {
    // TODO signOut logic
  }
}
