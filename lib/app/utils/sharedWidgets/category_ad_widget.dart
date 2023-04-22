import 'package:catalago_japamix/app/utils/sharedWidgets/text_button_widget.dart';
import 'package:catalago_japamix/base/models/category/category.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';
import 'checkbox_list_tile_widget.dart';

class CategoryAdWidget extends StatelessWidget {
  final Category category;
  final Function onTap;
  final Function? onDelete;
  final bool disableStyle;

  const CategoryAdWidget({
    Key? key,
    required this.onTap,
    required this.category,
    this.onDelete,
    this.disableStyle = false,
  }) : super(key: key);

  Widget getCheckboxWidget() => TextButtonWidget(
    widgetCustom: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTileWidget(
              radioText: category.name,
              size: 4.h,
              checked: category.selected,
              justRead: true,
            ),
          ),
          if(onDelete != null)
            InkWell(
              onTap: () => onDelete!(),
              child: Icon(
                Icons.delete,
                color: AppColors.blackColor,
                size: 2.5.h,
              ),
            ),
        ],
      ),
    ),
    onTap: () async => onTap(),
  );

  @override
  Widget build(BuildContext context) {
    return disableStyle ? getCheckboxWidget() : Container(
      padding: EdgeInsets.all(1.h),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.h),
        border: Border.all(
          color: AppColors.redColor,
          width: .25.h,
        ),
        color: AppColors.defaultColor,
      ),
      child: getCheckboxWidget(),
    );
  }
}
