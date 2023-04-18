// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'japamix_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JapaMixBase _$JapaMixBaseFromJson(Map<String, dynamic> json) => JapaMixBase(
      id: json['id'] as String,
      inclusion: DateTime.parse(json['inclusion'] as String),
      alteration: DateTime.parse(json['alteration'] as String),
      deleted: json['deleted'] as bool,
    );

Map<String, dynamic> _$JapaMixBaseToJson(JapaMixBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion.toIso8601String(),
      'alteration': instance.alteration.toIso8601String(),
      'deleted': instance.deleted,
    };
