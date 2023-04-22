import 'package:catalago_japamix/base/models/category/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../popup/category_ad_popup.dart';

class CategoryAdController extends GetxController {
  late RxBool allCategoriesSelected;
  late RxList<Category> categories;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;

  CategoryAdController(this.categories){
    _initializeVariables();
  }

  _initializeVariables(){
    allCategoriesSelected = false.obs;
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
  }

  selectAllCategories() {
    allCategoriesSelected.value = !allCategoriesSelected.value;

    for (var category in categories) {
      category.selected = allCategoriesSelected.value;
    }

    update(["categories-list"]);
  }

  saveCategory() {
    Get.back(result: categories);
  }

  addNewCategory() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CategoryAdPopup();
      },
    );
  }

  addCategoryToList(String categoryTitle) {
    if(categoryTitle.isNotEmpty){
      categories.add(
        Category(
          name: categoryTitle,
        ),
      );
      categories.sort((a, b) => a.name.compareTo(b.name));
      update(["categories-list"]);
    }
    Get.back();
  }

  onDeleteCategory(int index) async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Tem certeza que deseja remover a categoria?",
          firstButton: () {},
          secondButton: () {
            categories.removeAt(index);
            categories.sort((a, b) => a.name.compareTo(b.name));
            allCategoriesSelected.value = categories.where((category) => category.selected).length == categories.length;
            update(["categories-list"]);
          },
        );
      },
    );
  }
}
