import 'package:json_annotation/json_annotation.dart';

part 'address_information.g.dart';

@JsonSerializable()
class AddressInformation {
  late String uf;
  late String city;
  late String street;
  late String neighborhood;
  late String complement;

  AddressInformation({
    required this.uf,
    required this.city,
    required this.street,
    required this.neighborhood,
    required this.complement,
  });

  factory AddressInformation.fromJson(Map<String, dynamic> json) => _$AddressInformationFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInformationToJson(this);
}