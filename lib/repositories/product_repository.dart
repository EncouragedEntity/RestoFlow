import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:resto_flow/data/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:resto_flow/models/products/product.dart';

import '../models/products/image_dto.dart';

class ProductRepository {
  String hostname;

  ProductRepository({required this.hostname});

  Future<List<Product>> getAll() async {
    final response = await http.get(
      Uri.parse("$hostname$dineProduct/all"),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> jsonData =
          List<Map<String, dynamic>>.from(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );

      final List<Product> products = jsonData.map((jsonProduct) {
        final productData = jsonProduct["productDto"];
        final imagesData = jsonProduct["imageDto"];

        final List<Map<String, dynamic>> imagesMaps =
            List<Map<String, dynamic>>.from(imagesData);

        final List<ImageDto> images = imagesMaps
            .map((jsonImage) => ImageDto.fromJson(jsonImage))
            .toList();

        return Product.fromJson(productData).copyWith(images: images);
      }).toList();

      return products;
    } else {
      Logger().e("Failed to load products: ${response.reasonPhrase}");
      throw Exception('Failed to load products: ${response.reasonPhrase}');
    }
  }
}
