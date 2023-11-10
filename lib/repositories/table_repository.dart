import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/string_constants.dart';
import '../models/table.dart';

class TableRepository {
  String hostname;

  TableRepository({required this.hostname});

  Future<Table> getById(String tableId) async {
    final response = await http.get(
      Uri.parse('$hostname$dineTable/$tableId'),
    );

    if (response.statusCode == 200) {
      final Table table = Table.fromJson(
        jsonDecode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );

      return table;
    } else {
      throw Exception('Failed to get table by $tableId id');
    }
  }
}
