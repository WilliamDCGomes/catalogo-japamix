import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';

class PictureAdWidget extends StatelessWidget {
  final String path;
  final bool fromAsset;
  final Function? closeButton;

  const PictureAdWidget({
    Key? key,
    required this.path,
    this.closeButton,
    this.fromAsset = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 70.w,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.h),
              border: Border.all(
                color: AppColors.blackColor,
                width: .25.h,
              ),
              image: fromAsset
                  ? DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.fitWidth,
                      image: AssetImage(
                        path,
                      ),
                    )
                  : DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.fill,
                      image: MemoryImage(
                        base64Decode(path),
                      ),
                    ),
            ),
          ),
          Visibility(
            visible: closeButton != null,
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: closeButton != null ? () => closeButton!() : null,
                child: Container(
                  padding: EdgeInsets.all(.8.h),
                  margin: EdgeInsets.only(top: 1.h, right: 4.w,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.h),
                    color: AppColors.black40TransparentColor,
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColors.whiteColor,
                    size: 2.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
