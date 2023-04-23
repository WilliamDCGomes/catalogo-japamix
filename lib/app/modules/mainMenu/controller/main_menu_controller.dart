import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:catalago_japamix/base/services/interfaces/icategory_service.dart';
import 'package:catalago_japamix/base/services/interfaces/iestablishment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';
import '../../../../base/models/category/category.dart';
import '../../../../base/services/category_service.dart';
import '../../../../base/services/establishment_service.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/default_popup_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';

class MainMenuController extends GetxController {
  late TextEditingController searchByName;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late RxList<Establishment> visitPlaces;
  late RxList<Category> _categories;
  late final IEstablishmentService _establishmentService;
  late final ICategoryService _categoryService;

  MainMenuController() {
    _initializeVariables();
    _initializeMethods();
  }

  _initializeVariables() {
    searchByName = TextEditingController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _establishmentService = EstablishmentService();
    _categoryService = CategoryService();
    _categories = <Category>[].obs;
    visitPlaces = <Establishment>[].obs;
  }

  _initializeMethods() {
    getPlaces();
    getCategories();
  }

  void getPlaces() async {
    try {
      visitPlaces.value = [];
      visitPlaces.value = await _establishmentService.getAll();
    } catch (_) {
      visitPlaces.value = [];
    }
  }

  void getCategories() async {
    try {
      _categories.value = [];
      _categories.value = await _categoryService.getAll();
    } catch (_) {
      _categories.value = [];
    }
  }

  openFilter() async {
    bool allCategoriesSelected = true;
    await showDialog(
      context: Get.context!,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => DefaultPopupWidget(
          title: "Selecione a categoria que deseja mostrar",
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButtonWidget(
              widgetCustom: Align(
                alignment: Alignment.centerLeft,
                child: CheckboxListTileWidget(
                  radioText: "Selecionar todas",
                  size: 4.h,
                  checked: allCategoriesSelected,
                  justRead: true,
                  onChanged: () {},
                ),
              ),
              onTap: () async {
                setState(() {
                  allCategoriesSelected = !allCategoriesSelected;
                  for (var user in _categories) {
                    user.selected = allCategoriesSelected;
                  }
                });
              },
            ),
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                itemCount: _categories.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => TextButtonWidget(
                  widgetCustom: Align(
                    alignment: Alignment.centerLeft,
                    child: CheckboxListTileWidget(
                      radioText: _categories[index].description,
                      size: 4.h,
                      checked: _categories[index].selected,
                      justRead: true,
                      onChanged: () {},
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      _categories[index].selected = !_categories[index].selected;
                      if (allCategoriesSelected && !_categories[index].selected) {
                        allCategoriesSelected = _categories[index].selected;
                      } else if (!allCategoriesSelected && _categories[index].selected && _categories.length == 1) {
                        allCategoriesSelected = true;
                      }
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.h),
              child: ButtonWidget(
                hintText: "SELECIONAR",
                textSize: 16.sp,
                fontWeight: FontWeight.bold,
                widthButton: double.infinity,
                textColor: AppColors.blackColor,
                backgroundColor: AppColors.defaultColor,
                borderColor: AppColors.defaultColor,
                onPressed: () {
                  Get.back();

                  setState(() {
                    _categories.sort((a, b) => a.description.compareTo(b.description));
                    _categories.sort((a, b) => b.selected.toString().compareTo(a.selected.toString()));
                  });

                  if (_categories.where((element) => element.selected).length == _categories.length) {
                    //updateList();
                  } else {
                    //_filterListPerCities();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
