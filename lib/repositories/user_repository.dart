import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resto_flow/data/constants.dart';
import 'package:resto_flow/models/auth/auth_response_dto.dart';
import 'package:resto_flow/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    if (!await Permission.storage.isGranted) {
      await Permission.manageExternalStorage.request();
    }

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
      await storage.write(
        key: "accessToken",
        value: responseDto.authTokenDTO.accessToken,
      );

      Logger().i(
        await storage.read(key: "accessToken"),
      );

      return currentUser!;
    } else {
      throw Exception('Failed to sign in: ${response.reasonPhrase}');
    }
  }

  /// Automatic login by saved "accessToken"
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

  Future<User?> getUserById(int id) async {
    final response = await http.get(
      Uri.parse("${hostname!}$authUserId/$id"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
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

  /// Logs user out of the system
  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentUser = null;
    await prefs.remove("accessToken");
  }
}
