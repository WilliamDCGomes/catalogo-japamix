import 'package:carousel_slider/carousel_controller.dart';
import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:get/get.dart';
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
  @JsonKey(includeIfNull: false)
  List<String>? establishmentMediaIds;
  @JsonKey(includeIfNull: false)
  List<String>? categoryIds;
  @JsonKey(includeIfNull: false)
  String? categoryId;
  @JsonKey(includeToJson: false, includeFromJson: false)
  late RxList<String> imagesPlace;
  @JsonKey(includeToJson: false, includeFromJson: false)
  late String categoryName;
  @JsonKey(includeFromJson: false)
  late CarouselController carouselController;

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
    required this.cep,
    required this.primaryTelephoneIsWhatsapp,
    required super.id,
    this.establishmentMediaIds,
    this.categoryIds,
  }) : super(inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false) {
    imagesPlace = <String>[].obs;
    categoryName = "";
    categoryId = "";
  }

  factory Establishment.fromJson(Map<String, dynamic> json) => _$EstablishmentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);
}
