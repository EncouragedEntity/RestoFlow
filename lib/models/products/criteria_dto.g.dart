// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductFilter _$ProductFilterFromJson(Map<String, dynamic> json) =>
    ProductFilter(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as int,
      price: (json['price'] as num).toDouble(),
      measurmentUnitId: json['measurmentUnitId'] as int,
      restaurantId: json['restaurantId'] as int,
    );

Map<String, dynamic> _$ProductFilterToJson(ProductFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'price': instance.price,
      'measurmentUnitId': instance.measurmentUnitId,
      'restaurantId': instance.restaurantId,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      page: json['page'] as int,
      size: json['size'] as int,
      offset: json['offset'] as int,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'offset': instance.offset,
    };

CriteriaDto _$CriteriaDtoFromJson(Map<String, dynamic> json) => CriteriaDto(
      filterBy:
          ProductFilter.fromJson(json['filterBy'] as Map<String, dynamic>),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CriteriaDtoToJson(CriteriaDto instance) =>
    <String, dynamic>{
      'filterBy': instance.filterBy,
      'pagination': instance.pagination,
    };
