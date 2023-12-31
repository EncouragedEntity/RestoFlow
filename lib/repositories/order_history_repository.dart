import 'dart:convert';

import 'package:resto_flow/data/string_constants.dart';
import 'package:resto_flow/models/order/order_history_response_dto.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class OrderHistoryRepository {
  final String hostname = UserRepository.instance!.hostname!;

  Future<List<OrderHistoryResponseDto>> getHistory(int userId) async {
    try {
      final response = await http.get(
        Uri.parse("$hostname$history/$userId"),
        headers: {
          "Content-type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List) {
          List<OrderHistoryResponseDto> orderHistoryList = jsonResponse
              .map((json) => OrderHistoryResponseDto.fromJson(json))
              .toList();

          return orderHistoryList;
        } else {
          throw Exception("Invalid response format. Expected a list.");
        }
      } else {
        throw Exception(
            "Failed to load order history. Status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
}
