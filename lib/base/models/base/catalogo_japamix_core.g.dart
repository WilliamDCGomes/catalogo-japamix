// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogo_japamix_core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogoJapamixCore _$CatalogoJapamixCoreFromJson(Map<String, dynamic> json) =>
    CatalogoJapamixCore(
      id: json['id'] as String?,
      inclusion: json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String),
      alteration: json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String),
      active: CatalogoJapamixCore.fromJsonActive(json['active']),
    );

Map<String, dynamic> _$CatalogoJapamixCoreToJson(
        CatalogoJapamixCore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
    };
