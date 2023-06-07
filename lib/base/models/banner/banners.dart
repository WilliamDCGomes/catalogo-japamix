import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banners.g.dart';

@JsonSerializable()
class Banners extends JapaMixBase {
  final String base64;

  Banners({
    required this.base64,
    required super.id,
    required super.inclusion,
    DateTime? alteration,
    super.deleted = false,
  }) : super(alteration: alteration ?? DateTime.now());

  factory Banners.fromJson(Map<String, dynamic> json) => _$BannersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BannersToJson(this);
}
