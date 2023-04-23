import 'package:catalago_japamix/base/models/base/japamix_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'establishment_category.g.dart';

@JsonSerializable()
class EstablishmentCategory extends JapaMixBase {
  final String establishmentId;
  final String categoryId;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected;

  EstablishmentCategory({
    required this.establishmentId,
    required this.categoryId,
    required super.id,
    this.selected = false,
  }) : super(inclusion: DateTime.now(), alteration: DateTime.now(), deleted: false);

  factory EstablishmentCategory.fromJson(Map<String, dynamic> json) => _$EstablishmentCategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EstablishmentCategoryToJson(this);
}
