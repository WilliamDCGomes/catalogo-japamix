import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'establishment.g.dart';

@JsonSerializable()
class Establishment extends JapaMixBase {
  final String name;
  final String? description;
  final String primaryTelephone;
  final String? secondaryTelephone;
  final String? tertiaryTelephone;
  final String? address;
  final String? number;
  final String? district;
  final String? city;
  final String? state;
  final String? latitude;
  final String? longitude;
  final String categoryId;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<String> imagesPlace;

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
    required this.latitude,
    required this.longitude,
    required this.categoryId,
    required super.id,
    this.imagesPlace = const [],
  }) : super(inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false);

  factory Establishment.fromJson(Map<String, dynamic> json) => _$EstablishmentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EstablishmentToJson(this);
}
