import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/stylePages/app_colors.dart';

class BannerWidget extends StatelessWidget {
  final bool isAsset;
  final String image;

  const BannerWidget({
    super.key,
    this.isAsset = false,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(top: 6.h),
      decoration: BoxDecoration(
        color: AppColors.defaultColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5.h),
          bottomRight: Radius.circular(5.h),
        ),
        image: isAsset ? DecorationImage(
          alignment: Alignment.bottomCenter,
          fit: BoxFit.fitWidth,
          image: AssetImage(
            image,
          ),
        ) : DecorationImage(
          alignment: Alignment.bottomCenter,
          fit: BoxFit.cover,
          image: MemoryImage(
            base64Decode(image),
          ),
        ),
      ),
    );
  }
}
