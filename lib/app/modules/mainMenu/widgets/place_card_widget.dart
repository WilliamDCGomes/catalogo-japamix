import 'package:catalago_japamix/app/modules/detailAd/page/detail_ad_page.dart';
import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/category/category.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import 'image_place_card_widget.dart';

class PlaceCardWidget extends StatefulWidget{
  final Establishment place;
  final List<Category> categories;
  late final RxBool loading;

  PlaceCardWidget({
    Key? key,
    required this.place,
    required this.categories,
  }) : super(key: key){
    loading = true.obs;
  }

  @override
  State<PlaceCardWidget> createState() => _PlaceCardWidgetState();
}

class _PlaceCardWidgetState extends State<PlaceCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => DetailAdPage(
        establishment: widget.place,
        categories: widget.categories,
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
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget.loading.value)
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Center(
                    child: SizedBox(
                      height: 5.h,
                      width: 5.h,
                      child: const CircularProgressIndicator(
                        color: AppColors.redColor,
                      ),
                    ),
                  ),
                ) else if(widget.place.imagesPlace.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: ImagePlaceCardWidget(
                    firstImagePlace: widget.place.imagesPlace.first,
                  ),
                ) else
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Center(
                    child: TextWidget(
                      "Nenhuma imagem nesse anúncio",
                      textColor: AppColors.black40TransparentColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              Center(
                child: TextWidget(
                  widget.place.name,
                  textColor: AppColors.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              if (widget.place.address != null && widget.place.address!.isNotEmpty)
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
                            widget.place.address ?? "",
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
                      widget.place.primaryTelephone,
                      textColor: AppColors.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              if (widget.place.secondaryTelephone != null && widget.place.secondaryTelephone!.isNotEmpty)
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
                            widget.place.secondaryTelephone ?? "",
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
      ),
    );
  }
}
