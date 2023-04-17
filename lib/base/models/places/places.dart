import 'package:catalago_japamix/base/models/base/catalogo_japamix_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'places.g.dart';

@JsonSerializable()
class Places extends CatalogoJapamixCore {
  String name;
  String? description;
  String? place;
  String phone1;
  String? phone2;
  String? phone3;
  List<String>? imagesPlace;

  Places({
    required this.name,
    this.description,
    required this.phone1,
    this.phone2,
    this.phone3,
    this.place,
    this.imagesPlace,
  });

  factory Places.fromJson(Map<String, dynamic> json) => _$PlacesFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesToJson(this);
}