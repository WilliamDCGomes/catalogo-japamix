import 'package:catalago_japamix/app/utils/sharedWidgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../modules/mainMenu/widgets/place_card_widget.dart';

class CategoryListWidget extends StatefulWidget {
  final List<PlaceCardWidget> itens;

  const CategoryListWidget({
    Key? key,
    required this.itens,
  }) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      elements: widget.itens,
      groupBy: (item) => item.categories.firstWhere((category) => category.id == item.place.categoryIds.first).description,
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
      itemComparator: (first, second) => first.place.name.compareTo(second.place.name),
      order: GroupedListOrder.ASC,
      itemBuilder: (context, dynamic establishment) {
        return establishment;
      },
    );
  }
}
