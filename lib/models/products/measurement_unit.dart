import 'package:json_annotation/json_annotation.dart';

part 'measurement_unit.g.dart';

@JsonSerializable()
class MeasurementUnit {
  final int id;
  final String unitName;
  final String abbreviation;

  MeasurementUnit({
    required this.id,
    required this.unitName,
    required this.abbreviation,
  });

  factory MeasurementUnit.fromJson(Map<String, dynamic> json) =>
      _$MeasurementUnitFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementUnitToJson(this);
}
