import 'package:json_annotation/json_annotation.dart';

part 'japamix_base.g.dart';

@JsonSerializable()
class JapaMixBase<T> {
  final String id;
  final DateTime inclusion;
  final DateTime alteration;
  final bool deleted;

  JapaMixBase({
    required this.id,
    required this.inclusion,
    required this.alteration,
    required this.deleted,
  });

  factory JapaMixBase.fromJson(Map<String, dynamic> json) => _$JapaMixBaseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$JapaMixBaseToJson(this);
  static List<T> fromJsonList<T extends JapaMixBase>(List<dynamic> jsonList) {
    return jsonList.map((json) => _$JapaMixBaseFromJson(json) as T).toList();
  }
}
