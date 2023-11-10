import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:resto_flow/data/string_constants.dart';
import 'package:http/http.dart' as http;
import '../models/products/category.dart';

class CategoryRepository {
  String hostname;

  CategoryRepository({required this.hostname});

  Future<List<ProductCategory>> getAll(int restaurantId) async {
    final response = await http.get(
      Uri.parse("$hostname$dineProductCategory/all/$restaurantId"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonCategories =
          jsonDecode(utf8.decode(response.bodyBytes));
      final List<ProductCategory> categories = jsonCategories
          .map((jsonProduct) => ProductCategory.fromJson(jsonProduct))
          .toList();

      return categories;
    } else {
      Logger().e("Failed to load categories: ${response.reasonPhrase}");
      throw Exception('Failed to load categories: ${response.reasonPhrase}');
    }
  }
}
