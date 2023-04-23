// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstablishmentCategory _$EstablishmentCategoryFromJson(
        Map<String, dynamic> json) =>
    EstablishmentCategory(
      establishmentId: json['establishmentId'] as String,
      categoryId: json['categoryId'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$EstablishmentCategoryToJson(
        EstablishmentCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'establishmentId': instance.establishmentId,
      'categoryId': instance.categoryId,
    };
