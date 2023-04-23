import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'establishment.g.dart';

@JsonSerializable()
class Establishment extends JapaMixBase {
  final String name;
  final String? description;
  final String primaryTelephone;
  final bool primaryTelephoneIsWhatsapp;
  final String? secondaryTelephone;
  final String? tertiaryTelephone;
  final String? address;
  final String? number;
  final String? district;
  final String? city;
  final String? cep;
  final String? state;
  final String? complement;
  final String? latitude;
  final String? longitude;
  final String? categoryId;
  @JsonKey(includeIfNull: false)
  final List<String>? establishmentMediaIds;
  @JsonKey(includeIfNull: false)
  final List<String>? categoryIds;
  @JsonKey(includeToJson: false, includeFromJson: false)
  late List<String> imagesPlace;

  String get completeAddress => '$address, $number, $district, $city, $state, $cep';

  Establishment({
    required this.name,
    required this.description,
    required this.primaryTelephone,
    required this.secondaryTelephone,
    required this.tertiaryTelephone,
    required this.address,
    required this.number,
    required this.district,
    required this.city,
    required this.state,
    required this.complement,
    required this.latitude,
    required this.longitude,
    required this.categoryId,
    required this.cep,
    required this.primaryTelephoneIsWhatsapp,
    required super.id,
    List<String>? imagesPlace,
    this.establishmentMediaIds,
    this.categoryIds,
  }) : super(inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false) {
    this.imagesPlace = [];
  }

  factory Establishment.fromJson(Map<String, dynamic> json) => _$EstablishmentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);
}
