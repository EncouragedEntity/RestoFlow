import 'dart:convert';

import 'package:resto_flow/models/restaurant.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

import '../data/string_constants.dart';

class RestaurantRepository {
  final String hostname = UserRepository.instance!.hostname!;
  Future<Restaurant> getById(int id) async {
    final response = await http.get(Uri.parse("$hostname$restaurant/$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes));
      Restaurant restaurant = Restaurant.fromJson(jsonData);
      return restaurant;
    } else {
      throw Exception("Failed to load restaurant: ${response.reasonPhrase}");
    }
  }
}
