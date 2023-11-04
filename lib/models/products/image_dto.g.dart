// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDto _$ImageDtoFromJson(Map<String, dynamic> json) => ImageDto(
      id: json['id'] as int,
      tableId: json['tableId'] as int?,
      productId: json['productId'] as int,
      restaurantId: json['restaurantId'] as int,
      storageId: json['storageId'] as String,
      fileName: json['fileName'] as String,
      url: json['url'] as String,
      extension: json['extension'] as String,
    );

Map<String, dynamic> _$ImageDtoToJson(ImageDto instance) => <String, dynamic>{
      'id': instance.id,
      'tableId': instance.tableId,
      'productId': instance.productId,
      'restaurantId': instance.restaurantId,
      'storageId': instance.storageId,
      'fileName': instance.fileName,
      'url': instance.url,
      'extension': instance.extension,
    };
