import 'package:catalago_japamix/app/modules/detailAd/page/detail_ad_page.dart';
import 'package:catalago_japamix/base/models/places/places.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';

class PlaceCardWidget extends StatelessWidget {
  final Places place;

  const PlaceCardWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => DetailAdPage(place: place)),
      child: Container(
        padding: EdgeInsets.all(2.h),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: AppColors.defaultColorWithOpacity,
          border: Border.all(
            color: AppColors.blackColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            2.h,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TextWidget(
                place.name,
                textColor: AppColors.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            if(place.place != null && place.place!.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        size: 2.5.h,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: TextWidget(
                          place.place ?? "",
                          textColor: AppColors.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 2.5.h,
                  color: AppColors.blackColor,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: TextWidget(
                    place.phone1,
                    textColor: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            if(place.phone2 != null && place.phone2!.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 2.5.h,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: TextWidget(
                          place.phone2 ?? "",
                          textColor: AppColors.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
