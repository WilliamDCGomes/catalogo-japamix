import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/picture_ad_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/main_menu_banner_controller.dart';

class MainMenuBannerPage extends StatefulWidget {
  const MainMenuBannerPage({Key? key,}) : super(key: key);

  @override
  State<MainMenuBannerPage> createState() => _MainMenuBannerPageState();
}

class _MainMenuBannerPageState extends State<MainMenuBannerPage> {
  late MainMenuBannerController controller;

  @override
  void initState() {
    controller = Get.put(MainMenuBannerController());
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
                              "Configuração do Banner inicial",
                              textColor: AppColors.blackColor,
                              fontSize: 18.sp,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => Visibility(
                              visible: controller.allBanners.isNotEmpty,
                              replacement: Center(
                                child: TextWidget(
                                  "Nenhum banner adicionado",
                                  textColor: AppColors.blackColor,
                                  fontSize: 18.sp,
                                  maxLines: 2,
                                ),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.allBanners.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: InkWell(
                                    onTap: () => ViewPicture.openPicture(controller.allBanners[index].base64),
                                    onLongPress: () async => await controller.removePicture(index),
                                    child: LazyLoadingList(
                                      initialSizeOfItems: 2,
                                      index: index,
                                      loadMore: () {},
                                      hasMore: true,
                                      child: PictureAdWidget(
                                        fromAsset: false,
                                        path: controller.allBanners[index].base64,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Obx(
                            () => ButtonWidget(
                              hintText: "SALVAR",
                              fontWeight: FontWeight.bold,
                              widthButton: double.infinity,
                              borderColor: !controller.changed.value ? AppColors.grayBackgroundPictureColor : null,
                              onPressed: controller.changed.value ? () => controller.saveBanners() : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: FloatingActionButton(
                      onPressed: () => controller.addBanner(),
                      backgroundColor: AppColors.redColor,
                      elevation: 3,
                      child: const Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 40,
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
    );
  }
}
