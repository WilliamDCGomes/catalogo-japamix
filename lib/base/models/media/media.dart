import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media extends JapaMixBase {
  final String base64;
  final String? name;
  final MediaExtension extension;

  Media({
    required this.base64,
    required this.name,
    required this.extension,
    required super.id,
  }) : super(inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}

enum MediaExtension {
  @JsonValue(0)
  png,
  @JsonValue(1)
  jpeg,
  @JsonValue(2)
  jpg;
}
