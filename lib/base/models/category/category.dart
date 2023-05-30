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
    required super.inclusion,
    DateTime? alteration,
    super.deleted = false,
    this.selected = false,
  }) : super(alteration: alteration ?? DateTime.now());

  Category copyWith(Category category) {
    return Category(
      description: category.description,
      id: category.id,
      inclusion: category.inclusion,
      deleted: category.deleted,
      selected: category.selected,
      alteration: category.alteration,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
