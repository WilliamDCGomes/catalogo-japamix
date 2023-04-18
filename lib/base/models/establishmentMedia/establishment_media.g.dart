// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstablishmentMedia _$EstablishmentMediaFromJson(Map<String, dynamic> json) =>
    EstablishmentMedia(
      establishmentId: json['establishmentId'] as String,
      mediaId: json['mediaId'] as String,
      main: json['main'] as bool,
      id: json['id'] as String,
    );

Map<String, dynamic> _$EstablishmentMediaToJson(EstablishmentMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'establishmentId': instance.establishmentId,
      'mediaId': instance.mediaId,
      'main': instance.main,
    };
