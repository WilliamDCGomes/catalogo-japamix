// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Establishment _$EstablishmentFromJson(Map<String, dynamic> json) =>
    Establishment(
      name: json['name'] as String,
      description: json['description'] as String?,
      primaryTelephone: json['primaryTelephone'] as String,
      secondaryTelephone: json['secondaryTelephone'] as String?,
      tertiaryTelephone: json['tertiaryTelephone'] as String?,
      address: json['address'] as String?,
      number: json['number'] as String?,
      district: json['district'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      categoryId: json['categoryId'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$EstablishmentToJson(Establishment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'primaryTelephone': instance.primaryTelephone,
      'secondaryTelephone': instance.secondaryTelephone,
      'tertiaryTelephone': instance.tertiaryTelephone,
      'address': instance.address,
      'number': instance.number,
      'district': instance.district,
      'city': instance.city,
      'state': instance.state,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'categoryId': instance.categoryId,
    };
