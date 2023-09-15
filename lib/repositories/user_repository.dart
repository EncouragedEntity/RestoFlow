import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserRepository {
  final String? apiUrl;

  UserRepository({required this.apiUrl});

  Future<User> logIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/signin'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to sign in: ${response.reasonPhrase}');
    }
  }

  Future<User> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/signup'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to sign up: ${response.reasonPhrase}');
    }
  }

  Future<void> signOut() async {
    // TODO signOut logic
  }
}
