import 'package:catalago_japamix/app/modules/detailAd/controller/detail_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/establishment/establishment.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../widget/picture_ad_widget.dart';

class DetailAdPage extends StatefulWidget {
  final Establishment establishment;

  const DetailAdPage({
    Key? key,
    required this.establishment,
  }) : super(key: key);

  @override
  State<DetailAdPage> createState() => _DetailAdPageState();
}

class _DetailAdPageState extends State<DetailAdPage> {
  late DetailAdController controller;

  @override
  void initState() {
    controller = Get.put(DetailAdController(widget.establishment));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.backgroundFirstScreenColor,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 30.h,
                    margin: EdgeInsets.only(top: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.defaultColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.h),
                        bottomRight: Radius.circular(5.h),
                      ),
                      image: const DecorationImage(
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          Paths.backgroundImage,
                        ),
                      ),
                    ),
                  ),
                ),
                Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: AppColors.defaultColor,
                    title: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.blackColor,
                              size: 2.5.h,
                            ),
                          ),
                        ),
                        Center(
                          child: TextWidget(
                            "GUIA MIX",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    elevation: 5,
                  ),
                  backgroundColor: AppColors.transparentColor,
                  body: Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 15.h, right: 4.w),
                    child: Column(
                      children: [
                        Center(
                          child: InformationContainerWidget(
                            iconPath: Paths.iconeGuiaMixTransparente,
                            disableWhiteIconColor: true,
                            showBorder: true,
                            textColor: AppColors.blackColor,
                            backgroundColor: AppColors.defaultColor,
                            informationText: "",
                            customContainer: TextWidget(
                              controller.visitPlace.name,
                              textColor: AppColors.blackColor,
                              fontSize: 18.sp,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              if (controller.visitPlace.description != null && controller.visitPlace.description != "")
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Descrição",
                                      textColor: AppColors.blackColor,
                                      fontSize: 18.sp,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                                      child: TextWidget(
                                        controller.visitPlace.description ?? "",
                                        textColor: AppColors.blackColor,
                                        fontSize: 16.sp,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.bold,
                                        maxLines: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              if (controller.visitPlace.imagesPlace != null && controller.visitPlace.imagesPlace!.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Fotos",
                                      textColor: AppColors.blackColor,
                                      fontSize: 18.sp,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.h),
                                      child: SizedBox(
                                        height: 20.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: controller.visitPlace.imagesPlace!.length,
                                          itemBuilder: (context, index) {
                                            return PictureAdWidget(
                                              path: controller.visitPlace.imagesPlace![index],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (controller.visitPlace.address != null && controller.visitPlace.address != "")
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Localização",
                                      textColor: AppColors.blackColor,
                                      fontSize: 18.sp,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.map,
                                              size: 2.5.h,
                                              color: AppColors.blackColor,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            TextWidget(
                                              controller.visitPlace.address ?? "",
                                              textColor: AppColors.blackColor,
                                              fontSize: 16.sp,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.bold,
                                              textDecoration: TextDecoration.underline,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    "Telefone${(controller.visitPlace.secondaryTelephone != null && controller.visitPlace.secondaryTelephone!.isNotEmpty) || (controller.visitPlace.secondaryTelephone != null && controller.visitPlace.secondaryTelephone!.isNotEmpty) ? "s" : ""} para contato",
                                    textColor: AppColors.blackColor,
                                    fontSize: 18.sp,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 2.5.h,
                                          color: AppColors.blackColor,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        TextWidget(
                                          controller.visitPlace.primaryTelephone,
                                          textColor: AppColors.blackColor,
                                          fontSize: 16.sp,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.bold,
                                          textDecoration: TextDecoration.underline,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (controller.visitPlace.secondaryTelephone != null &&
                                      controller.visitPlace.secondaryTelephone != "")
                                    TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 2.5.h,
                                            color: AppColors.blackColor,
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          TextWidget(
                                            controller.visitPlace.secondaryTelephone ?? "",
                                            textColor: AppColors.blackColor,
                                            fontSize: 16.sp,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            textDecoration: TextDecoration.underline,
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (controller.visitPlace.tertiaryTelephone != null &&
                                      controller.visitPlace.tertiaryTelephone != "")
                                    TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 2.5.h,
                                            color: AppColors.blackColor,
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          TextWidget(
                                            controller.visitPlace.tertiaryTelephone ?? "",
                                            textColor: AppColors.blackColor,
                                            fontSize: 16.sp,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            textDecoration: TextDecoration.underline,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.loadingWithSuccessOrErrorWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
