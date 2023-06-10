import 'dart:io';
import 'package:catalago_japamix/app/modules/detailAd/controller/detail_ad_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../base/models/category/category.dart';
import '../../../../base/models/establishment/establishment.dart';
import '../../../../flavors.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/picture_ad_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../createEditAd/page/create_edit_ad_page.dart';

class DetailAdPage extends StatefulWidget {
  final Establishment establishment;
  final List<Category> categories;

  const DetailAdPage({
    Key? key,
    required this.establishment,
    required this.categories,
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if(F.isAdm)
                                Padding(
                                  padding: EdgeInsets.only(right: 4.w),
                                  child: InkWell(
                                    onTap: () async {
                                      final establishment = await Get.to(() => CreateEditAdPage(
                                            place: controller.visitPlace,
                                            categories: widget.categories,
                                          ));
                                      if (establishment != null) {
                                        setState(() {
                                          controller.visitPlace = establishment;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.blackColor,
                                      size: 3.h,
                                    ),
                                  ),
                                ),
                              InkWell(
                                onTap: () => controller.shareAd(),
                                child: Icon(
                                  Icons.share,
                                  color: AppColors.blackColor,
                                  size: 3.h,
                                ),
                              ),
                              if(F.isAdm)
                                Padding(
                                  padding: EdgeInsets.only(left: 4.w),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: Get.context!,
                                        builder: (BuildContext context) {
                                          return ConfirmationPopup(
                                            title: "Aviso",
                                            subTitle: "Tem certeza que deseja apagar esse anúncio?",
                                            firstButton: () {},
                                            secondButton: () => controller.deleteAd(),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.blackColor,
                                      size: 3.h,
                                    ),
                                  ),
                                ),
                            ],
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
                              GetBuilder<DetailAdController>(
                                  init: controller,
                                  id: 'imagem',
                                  builder: (controller) {
                                    if (controller.visitPlace.imagesPlace.isNotEmpty) {
                                      return Column(
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
                                            padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                                            child: SizedBox(
                                              height: 20.h,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: controller.visitPlace.imagesPlace.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () =>
                                                        ViewPicture.openPicture(controller.visitPlace.imagesPlace[index]),
                                                    child: LazyLoadingList(
                                                      initialSizeOfItems: 2,
                                                      index: index,
                                                      loadMore: () {},
                                                      hasMore: true,
                                                      child: PictureAdWidget(
                                                        fromAsset: false,
                                                        path: controller.visitPlace.imagesPlace[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return const SizedBox();
                                  }),
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
                                        onPressed: () async {
                                          String completeAddress =
                                              "https://www.google.com/maps/search/?api=1&query=${controller.visitPlace.address ?? ''}, ${controller.visitPlace.number ?? ''}, "
                                              "${controller.visitPlace.district ?? ''}, ${controller.visitPlace.cep ?? ''}";
                                          if (Platform.isIOS) {
                                            completeAddress =
                                                "http://maps.apple.com/?q=${controller.visitPlace.address ?? ''}, ${controller.visitPlace.number ?? ''}, "
                                                "${controller.visitPlace.district ?? ''}, ${controller.visitPlace.cep ?? ''}";
                                          }

                                          await launchUrl(Uri.parse(completeAddress),
                                              mode: LaunchMode.externalNonBrowserApplication);
                                        },
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
                                            Expanded(
                                              child: TextWidget(
                                                controller.visitPlace.completeAddress,
                                                textColor: AppColors.blackColor,
                                                fontSize: 16.sp,
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.bold,
                                                maxLines: 5,
                                                textDecoration: TextDecoration.underline,
                                              ),
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
                                    onPressed: () async {
                                      if (controller.visitPlace.primaryTelephoneIsWhatsapp) {
                                        launchUrl(
                                            Uri.parse(
                                                "https://api.whatsapp.com/send?phone=55${controller.visitPlace.primaryTelephone}"),
                                            mode: LaunchMode.externalNonBrowserApplication);
                                      } else {
                                        launchUrl(Uri.parse("tel:${controller.visitPlace.primaryTelephone}"),
                                            mode: Platform.isAndroid
                                                ? LaunchMode.externalNonBrowserApplication
                                                : LaunchMode.externalApplication);
                                      }
                                    },
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
                                      onPressed: () {
                                        launchUrl(Uri.parse("tel:${controller.visitPlace.secondaryTelephone}"),
                                            mode: Platform.isAndroid
                                                ? LaunchMode.externalNonBrowserApplication
                                                : LaunchMode.externalApplication);
                                      },
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
                                      onPressed: () {
                                        launchUrl(Uri.parse("tel:${controller.visitPlace.tertiaryTelephone}"),
                                            mode: Platform.isAndroid
                                                ? LaunchMode.externalNonBrowserApplication
                                                : LaunchMode.externalApplication);
                                      },
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
