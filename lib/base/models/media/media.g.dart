// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      base64: json['base64'] as String,
      name: json['name'] as String?,
      extension: $enumDecode(_$MediaExtensionEnumMap, json['extension']),
      id: json['id'] as String,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'base64': instance.base64,
      'name': instance.name,
      'extension': _$MediaExtensionEnumMap[instance.extension]!,
    };

const _$MediaExtensionEnumMap = {
  MediaExtension.png: 'png',
  MediaExtension.jpeg: 'jpeg',
  MediaExtension.jpg: 'jpg',
};
