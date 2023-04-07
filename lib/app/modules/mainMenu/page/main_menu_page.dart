import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/main_menu_controller.dart';
import '../widget/place_card_widget.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  late MainMenuController controller;

  @override
  void initState() {
    controller = Get.put(MainMenuController());
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
                    backgroundColor: AppColors.defaultColor,
                    title: Stack(
                      children: [
                        Center(
                          child: TextWidget(
                            "GUIA MIX",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => controller.openFilter(),
                            child: Icon(
                              Icons.filter_list_alt,
                              color: AppColors.blackColor,
                              size: 3.h,
                            ),
                          ),
                        )
                      ],
                    ),
                    elevation: 5,
                  ),
                  backgroundColor: AppColors.transparentColor,
                  body: Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InformationContainerWidget(
                          iconPath: Paths.iconeGuiaMixTransparente,
                          disableWhiteIconColor: true,
                          showBorder: true,
                          textColor: AppColors.blackColor,
                          backgroundColor: AppColors.defaultColor,
                          informationText: "",
                          customContainer: TextWidget(
                            "Lista de utilidade pública interativa",
                            textColor: AppColors.blackColor,
                            fontSize: 18.sp,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => Visibility(
                              visible: controller.visitPlaces.isNotEmpty,
                              replacement: const Center(
                                child: TextWidget(
                                  "Nenhum local encontrado",
                                  textColor: AppColors.blackColor,
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: controller.visitPlaces.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 2.h),
                                itemBuilder: (context, index) {
                                  return PlaceCardWidget(
                                    place: controller.visitPlaces[index],
                                  );
                                },
                              ),
                            ),
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