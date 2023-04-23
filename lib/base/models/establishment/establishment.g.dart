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
      complement: json['complement'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      categoryId: json['categoryId'] as String?,
      cep: json['cep'] as String?,
      primaryTelephoneIsWhatsapp: json['primaryTelephoneIsWhatsapp'] as bool,
      id: json['id'] as String,
      establishmentMediaIds: (json['establishmentMediaIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoryIds: (json['categoryIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EstablishmentToJson(Establishment instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'description': instance.description,
    'primaryTelephone': instance.primaryTelephone,
    'primaryTelephoneIsWhatsapp': instance.primaryTelephoneIsWhatsapp,
    'secondaryTelephone': instance.secondaryTelephone,
    'tertiaryTelephone': instance.tertiaryTelephone,
    'address': instance.address,
    'number': instance.number,
    'district': instance.district,
    'city': instance.city,
    'cep': instance.cep,
    'state': instance.state,
    'complement': instance.complement,
    'latitude': instance.latitude,
    'longitude': instance.longitude,
    'categoryId': instance.categoryId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('establishmentMediaIds', instance.establishmentMediaIds);
  writeNotNull('categoryIds', instance.categoryIds);
  return val;
}
