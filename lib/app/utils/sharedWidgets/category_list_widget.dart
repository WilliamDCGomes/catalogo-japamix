import 'package:catalago_japamix/app/utils/sharedWidgets/text_widget.dart';
import 'package:catalago_japamix/base/models/category/category.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../base/models/establishment/establishment.dart';
import '../../modules/mainMenu/widget/place_card_widget.dart';

class CategoryListWidget extends StatelessWidget {
  final List<dynamic> itens;
  final List<dynamic> categories;

  const CategoryListWidget({
    Key? key,
    required this.itens,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      elements: itens.map((e) => e.toJson()).toList(),
      groupBy: (place) => categories.firstWhere((category) => category.id == place["categoryId"]).name,
      groupSeparatorBuilder: (String groupByValue) => Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: TextWidget(
          groupByValue,
          maxLines: 3,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          textDecoration: TextDecoration.underline,
        ),
      ),
      itemComparator: (firstName, secondName) => firstName['name'].compareTo(secondName['name']),
      order: GroupedListOrder.ASC,
      itemBuilder: (context, dynamic establishment) {
        return PlaceCardWidget(
          place: Establishment.fromJson(establishment),
          categories: categories as List<Category>,
        );
      },
    );
  }
}
