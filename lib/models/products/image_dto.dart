import 'package:json_annotation/json_annotation.dart';

part 'image_dto.g.dart';

@JsonSerializable()
class ImageDto {
  final int? id;
  final int? tableId;
  final int? productId;
  final int? restaurantId;
  final String? storageId;
  final String? fileName;
  final String url;
  final String? extension;

  ImageDto({
    required this.id,
    this.tableId,
    this.productId,
    this.restaurantId,
    this.storageId,
    this.fileName,
    required this.url,
    this.extension,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) =>
      _$ImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImageDtoToJson(this);
}
