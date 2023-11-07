import 'dart:convert';

import 'package:resto_flow/data/string_constants.dart';
import 'package:resto_flow/models/products/measurement_unit.dart';
import 'package:http/http.dart' as http;
import 'package:resto_flow/repositories/user_repository.dart';

class MeasurementUnitRepository {
  final String hostname = UserRepository.instance?.hostname ?? "";
  List<MeasurementUnit> _units = [];
  List<MeasurementUnit> get units => _units;

  MeasurementUnitRepository._();

  static final MeasurementUnitRepository _instance =
      MeasurementUnitRepository._();

  factory MeasurementUnitRepository() {
    return _instance;
  }

  Future<void> getAll() async {
    final response = await http.get(
      Uri.parse("$hostname$measurementUnit/all"),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(
        utf8.decode(
          response.bodyBytes,
        ),
      );
      _units = data.map((json) => MeasurementUnit.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load measurement units');
    }
  }

  MeasurementUnit getById(int id) {
    return _units.firstWhere(
      (unit) => unit.id == id,
      orElse: () => _units[0],
    );
  }
}
