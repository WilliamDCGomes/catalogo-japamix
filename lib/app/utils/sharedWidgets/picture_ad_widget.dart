import 'dart:io';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';

class PictureAdWidget extends StatelessWidget {
  final String path;

  const PictureAdWidget({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 20.h,
    width: 70.w,
    margin: EdgeInsets.only(right: 2.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.h),
      border: Border.all(
        color: AppColors.blackColor,
        width: .25.h,
      ),
      image: DecorationImage(
        alignment: Alignment.bottomCenter,
        fit: BoxFit.fitWidth,
        image: MemoryImage(
          File(
            path,
          ).readAsBytesSync(),
        ),
      ),
    ),
      );
  }
}
