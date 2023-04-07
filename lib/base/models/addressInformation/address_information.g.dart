// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressInformation _$AddressInformationFromJson(Map<String, dynamic> json) =>
    AddressInformation(
      uf: json['uf'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      neighborhood: json['neighborhood'] as String,
      complement: json['complement'] as String,
    );

Map<String, dynamic> _$AddressInformationToJson(AddressInformation instance) =>
    <String, dynamic>{
      'uf': instance.uf,
      'city': instance.city,
      'street': instance.street,
      'neighborhood': instance.neighborhood,
      'complement': instance.complement,
    };
