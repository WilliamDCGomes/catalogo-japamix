import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'establishment_media.g.dart';

@JsonSerializable()
class EstablishmentMedia extends JapaMixBase {
  late String establishmentId;
  late String mediaId;
  late bool main;

  EstablishmentMedia({
    required this.establishmentId,
    required this.mediaId,
    required this.main,
    required super.id,
  }) : super(inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false);

  factory EstablishmentMedia.fromJson(Map<String, dynamic> json) => _$EstablishmentMediaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EstablishmentMediaToJson(this);
}
