// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      description: json['description'] as String,
      id: json['id'] as String,
      inclusion: DateTime.parse(json['inclusion'] as String),
      alteration: json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String),
      deleted: json['deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion.toIso8601String(),
      'alteration': instance.alteration.toIso8601String(),
      'deleted': instance.deleted,
      'description': instance.description,
    };
