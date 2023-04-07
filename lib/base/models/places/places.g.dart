// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Places _$PlacesFromJson(Map<String, dynamic> json) => Places(
      name: json['name'] as String,
      description: json['description'] as String?,
      phone1: json['phone1'] as String,
      phone2: json['phone2'] as String?,
      phone3: json['phone3'] as String?,
      place: json['place'] as String?,
    )
      ..id = json['id'] as String?
      ..inclusion = json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String)
      ..alteration = json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String)
      ..active = CatalogoJapamixCore.fromJsonActive(json['active']);

Map<String, dynamic> _$PlacesToJson(Places instance) => <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
      'name': instance.name,
      'description': instance.description,
      'place': instance.place,
      'phone1': instance.phone1,
      'phone2': instance.phone2,
      'phone3': instance.phone3,
    };
