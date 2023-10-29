import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:resto_flow/data/constants.dart';
import 'package:http/http.dart' as http;
import 'package:resto_flow/models/products/product.dart';

class ProductRepository {
  final hostname = dineProduct;

  Future<List<Product>> getAll() async {
    final response = await http.get(
      Uri.parse("$hostname/all"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonProducts = jsonDecode(response.body);
      final List<Product> products = jsonProducts
          .map((jsonProduct) => Product.fromJson(jsonProduct))
          .toList();

      return products;
    } else {
      Logger().e("Failed to load products: ${response.reasonPhrase}");
      throw Exception('Failed to load products: ${response.reasonPhrase}');
    }
  }
}
