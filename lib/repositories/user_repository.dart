import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:resto_flow/data/string_constants.dart';
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

  /// Logs in a user using [email] and [password]
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
      final Map<String, dynamic> data = jsonDecode(
        utf8.decode(response.bodyBytes),
      );
      final AuthResponseDto responseDto = AuthResponseDto.fromJson(data);
      currentUser = responseDto.userDTO;

      const storage = FlutterSecureStorage();
      await storage.write(
        key: "accessToken",
        value: responseDto.authTokenDTO.accessToken,
      );

      return currentUser!;
    } else {
      Logger().e('Failed to sign in: ${response.reasonPhrase}');
      Logger().e(response.body);

      throw Exception('Failed to sign in: ${response.reasonPhrase}');
    }
  }

  /// Automatic login by saved "accessToken" from secure storage
  Future<User?> automaticLogin() async {
    const storage = FlutterSecureStorage();

    final accessToken = await storage.read(key: "accessToken");

    if (accessToken == null) {
      return null;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      final userId = decodedToken["user_id"];
      if (userId == null || userId == 0) {
        return null;
      }
      currentUser = await getUserById(userId);
      return currentUser;
    } on Exception catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }

  /// Gets userDto from db by it's [id]
  Future<User?> getUserById(int id) async {
    final response = await http.get(
      Uri.parse("${hostname!}$authUserAccount/$id"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return User.fromJson(json);
    }
    return null;
  }

  /// Gets userDto from db by it's [email]
  Future<User?> getUserByEmail(String email) async {
    final response = await http.get(
      Uri.parse("${hostname!}$authUserAccount/email"),
      headers: {
        'Content-Type': 'application/json',
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return User.fromJson(json);
    }
    return null;
  }

  /// Creates user account using [email] and [password]
  Future<User> register(String email, String password) async {
    final user = User(
      username: email,
      email: email,
      firstName: "",
      lastName: "",
      authorities: ["USER"],
      password: password,
    );

    final userJson = user.toJsonString();

    final response = await http.post(
      Uri.parse(hostname! + authRegisterUrl),
      body: userJson,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes));
      currentUser = User.fromJson(data);
      return currentUser!;
    } else {
      throw Exception('Failed to sign up: ${response.reasonPhrase}');
    }
  }

  Future<User> update(String email, User newUserData) async {
    final existingUser = await getUserByEmail(email);
    if (existingUser != null) {
      final updatedUser = existingUser.copyWith(
        username: newUserData.username,
        email: newUserData.email,
        firstName: newUserData.firstName,
        lastName: newUserData.lastName,
        password: newUserData.password,
      );
      final response = await http.put(
        Uri.parse("${hostname!}$authUserAccount/$email"),
        body: updatedUser.toJsonString(),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Logger().i("Updated succesfully!");
        Logger().i(updatedUser.toJsonString());
        UserRepository.currentUser = updatedUser;

        return updatedUser;
      }
    }
    throw Exception("User with email $email not found.");
  }

  /// Logs user out of the system
  Future<void> logOut() async {
    const storage = FlutterSecureStorage();

    currentUser = null;
    await storage.delete(key: "accessToken");
  }
}
