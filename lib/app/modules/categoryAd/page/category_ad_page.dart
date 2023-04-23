import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/category/category.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/category_ad_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/category_ad_controller.dart';

class CategoryAdPage extends StatefulWidget {
  final List<Category> categories;

  const CategoryAdPage({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<CategoryAdPage> createState() => _CategoryAdPageState();
}

class _CategoryAdPageState extends State<CategoryAdPage> {
  late CategoryAdController controller;

  @override
  void initState() {
    controller = Get.put(CategoryAdController(widget.categories.obs), tag: "category-ad-controller");
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Selecione as categorias que você deseja para o anúncio",
                              textColor: AppColors.blackColor,
                              fontSize: 18.sp,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: TextButtonWidget(
                              onTap: () => controller.selectAllCategories(),
                              width: 40.w,
                              widgetCustom: Align(
                                alignment: Alignment.centerLeft,
                                child: CheckboxListTileWidget(
                                  radioText: "Selecionar Todos",
                                  size: 4.h,
                                  checked: controller.allCategoriesSelected.value,
                                  justRead: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GetBuilder(
                            init: controller,
                            id: "categories-list",
                            builder: (_) => ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 5.h),
                              itemCount: controller.categories.length,
                              itemBuilder: (context, index) {
                                return CategoryAdWidget(
                                  category: controller.categories[index],
                                  onDelete: () => controller.onDeleteCategory(index),
                                  onTap: () async {
                                    setState(() {
                                      controller.categories[index].selected = !controller.categories[index].selected;
                                      if(controller.allCategoriesSelected.value && !controller.categories[index].selected){
                                        controller.allCategoriesSelected.value = controller.categories[index].selected;
                                      }
                                      else {
                                        controller.allCategoriesSelected.value = (!controller.allCategoriesSelected.value && controller.categories[index].selected && controller.categories.length == 1) ||
                                            (!controller.allCategoriesSelected.value && controller.categories.where((category) => category.selected).length == controller.categories.length);
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: ButtonWidget(
                            hintText: "SALVAR CATEGORIAS",
                            fontWeight: FontWeight.bold,
                            widthButton: double.infinity,
                            onPressed: () => controller.saveCategory(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: FloatingActionButton(
                      onPressed: () => controller.addNewCategory(),
                      backgroundColor: AppColors.redColor,
                      elevation: 3,
                      child: Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 4.h,
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
