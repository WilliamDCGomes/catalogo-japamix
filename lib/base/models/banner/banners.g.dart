// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banners _$BannersFromJson(Map<String, dynamic> json) => Banners(
      base64: json['base64'] as String,
      id: json['id'] as String,
      inclusion: DateTime.parse(json['inclusion'] as String),
      alteration: json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String),
      deleted: json['deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion.toIso8601String(),
      'alteration': instance.alteration.toIso8601String(),
      'deleted': instance.deleted,
      'base64': instance.base64,
    };
