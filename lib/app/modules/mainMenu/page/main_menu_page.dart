import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../flavors.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/category_list_widget.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../mainMenuBanner/page/main_menu_banner_page.dart';
import '../../mainMenuBanner/widget/banner_widget.dart';
import '../controller/main_menu_controller.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  late MainMenuController controller;

  @override
  void initState() {
    controller = Get.put(MainMenuController(), tag: "main-menu-controller");
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
            child: RefreshIndicator(
              onRefresh: () => controller.refreshPage(),
              child: Stack(
                children: [
                  Scaffold(
                    backgroundColor: AppColors.transparentColor,
                    body: Padding(
                      padding: EdgeInsets.only(left: 4.w, top: 32.h, right: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Obx(
                              () => Visibility(
                                visible: controller.visitPlaces.isNotEmpty,
                                replacement: Center(
                                  child: TextWidget(
                                    "Nenhum local encontrado",
                                    textColor: AppColors.blackColor,
                                    fontSize: 18.sp,
                                    maxLines: 2,
                                  ),
                                ),
                                child: CategoryListWidget(
                                  itens: controller.visitPlaces,
                                  scrollController: controller.scrollController,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    floatingActionButton: F.isAdm ? FloatingActionButton(
                      onPressed: () => controller.addAd(),
                      backgroundColor: AppColors.redColor,
                      elevation: 3,
                      child: const Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 40,
                      ),
                    ) : null,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Obx(
                      () => Visibility(
                        visible: controller.allBanners.isEmpty,
                        replacement: CarouselSlider.builder(
                          carouselController: controller.carouselController,
                          itemCount: controller.allBanners.length,
                          options: CarouselOptions(
                              height: 30.h,
                              viewportFraction: 1,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              autoPlay: controller.allBanners.length > 1,
                              autoPlayInterval: const Duration(seconds: 5),
                              onPageChanged: (itemIndex, reason){
                                controller.activeStep.value = itemIndex;
                              }
                          ),
                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                            return BannerWidget(
                              image: controller.allBanners[itemIndex].base64,
                            );
                          },
                        ),
                        child: const BannerWidget(
                          image: Paths.backgroundImage,
                          isAsset: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 7.h,
                    color: AppColors.defaultColor,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 1.h,
                        ),
                        Expanded(
                          child: TextWidget(
                            "GUIA MIX",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: InkWell(
                            onTap: () => controller.openFilter(),
                            child: Icon(
                              Icons.menu,
                              color: AppColors.blackColor,
                              size: 3.h,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GetBuilder(
                    id: "stepper",
                    init: controller,
                    builder: (_) => Obx(
                      () => Visibility(
                        visible: controller.allBanners.length > 2,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 5.h,
                                padding: EdgeInsets.all(1.h),
                                margin: EdgeInsets.only(top: Platform.isAndroid ? 7.5.h : 9.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.h),
                                  color: AppColors.black40TransparentColor,
                                ),
                                child: Center(
                                  child: DotStepper(
                                    dotCount: controller.allBanners.length < 2 ? 2 : controller.allBanners.length,
                                    dotRadius: .8.h,
                                    activeStep: controller.activeStep.value,
                                    shape: Shape.circle,
                                    spacing: 3.w,
                                    indicator: Indicator.magnify,
                                    fixedDotDecoration: const FixedDotDecoration(
                                      color: AppColors.grayStepColor,
                                    ),
                                    indicatorDecoration: const IndicatorDecoration(
                                      color: AppColors.whiteColor,
                                    ),
                                    onDotTapped: (tappedDotIndex) {
                                      controller.activeStep.value = tappedDotIndex;
                                      controller.carouselController.jumpToPage(tappedDotIndex);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 20.h, right: 4.w),
                    child: InformationContainerWidget(
                      iconPath: Paths.iconeGuiaMixTransparente,
                      disableWhiteIconColor: true,
                      showBorder: true,
                      textColor: AppColors.blackColor,
                      backgroundColor: AppColors.defaultColor,
                      informationText: "",
                      customContainer: TextWidget(
                        "Lista de utilidade pública",
                        textColor: AppColors.blackColor,
                        fontSize: 18.sp,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: F.isAdm,
                    child: Padding(
                      padding: EdgeInsets.only(top: Platform.isAndroid ? 7.5.h : 9.h, right: 4.w),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => Get.to(() => const MainMenuBannerPage()),
                          child: Container(
                            padding: EdgeInsets.all(1.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color: AppColors.black40TransparentColor,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.whiteColor,
                              size: 3.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  controller.loadingWithSuccessOrErrorWidget,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
