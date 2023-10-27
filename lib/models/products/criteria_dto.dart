import 'package:json_annotation/json_annotation.dart';

part 'criteria_dto.g.dart';

@JsonSerializable()
class ProductFilter {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final double price;
  final int measurmentUnitId;
  final int restaurantId;

  ProductFilter({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.measurmentUnitId,
    required this.restaurantId,
  });

  factory ProductFilter.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterFromJson(json);
  Map<String, dynamic> toJson() => _$ProductFilterToJson(this);
}

@JsonSerializable()
class Pagination {
  final int page;
  final int size;
  final int offset;

  Pagination({
    required this.page,
    required this.size,
    required this.offset,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class CriteriaDto {
  final ProductFilter filterBy;
  final Pagination pagination;

  CriteriaDto({
    required this.filterBy,
    required this.pagination,
  });

  factory CriteriaDto.fromJson(Map<String, dynamic> json) =>
      _$CriteriaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CriteriaDtoToJson(this);
}
