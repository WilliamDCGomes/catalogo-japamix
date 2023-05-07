import 'package:catalago_japamix/app/modules/detailAd/page/detail_ad_page.dart';
import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/category/category.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import 'image_place_card_widget.dart';

class PlaceCardWidget extends StatelessWidget {
  final Establishment place;
  final String firstImagePlace;
  final List<Category> categories;

  const PlaceCardWidget({
    Key? key,
    required this.place,
    required this.firstImagePlace,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => DetailAdPage(
        establishment: place,
        categories: categories,
      )),
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
            if(firstImagePlace.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: ImagePlaceCardWidget(
                  firstImagePlace: firstImagePlace,
                ),
              ),
            Center(
              child: TextWidget(
                place.name,
                textColor: AppColors.blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            if (place.address != null && place.address!.isNotEmpty)
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
                          place.address ?? "",
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
                    place.primaryTelephone,
                    textColor: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            if (place.secondaryTelephone != null && place.secondaryTelephone!.isNotEmpty)
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
                          place.secondaryTelephone ?? "",
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
