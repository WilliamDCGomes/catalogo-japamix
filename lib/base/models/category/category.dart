import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends JapaMixBase {
  final String description;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected;

  Category({
    required this.description,
    required super.id,
    this.selected = false,
  }) : super(inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
