import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends JapaMixBase {
  final String name;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected;

  Category({
    required this.name,
    this.selected = false,
  }) : super(id: const Uuid().v4(), inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
