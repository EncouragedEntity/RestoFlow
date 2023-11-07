// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementUnit _$MeasurementUnitFromJson(Map<String, dynamic> json) =>
    MeasurementUnit(
      id: json['id'] as int,
      unitName: json['unitName'] as String,
      abbreviation: json['abbreviation'] as String,
    );

Map<String, dynamic> _$MeasurementUnitToJson(MeasurementUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unitName': instance.unitName,
      'abbreviation': instance.abbreviation,
    };
