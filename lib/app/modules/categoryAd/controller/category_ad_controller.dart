import 'package:catalago_japamix/base/models/category/category.dart';
import 'package:catalago_japamix/base/services/category_service.dart';
import 'package:catalago_japamix/base/services/interfaces/icategory_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../popup/category_ad_popup.dart';

class CategoryAdController extends GetxController {
  late RxBool allCategoriesSelected;
  late RxList<Category> categories;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late final ICategoryService _categoryService;

  CategoryAdController(this.categories) {
    _initializeVariables();
  }

  _initializeVariables() {
    allCategoriesSelected = false.obs;
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _categoryService = CategoryService();
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

  addCategoryToList(String categoryTitle) async {
    final category = Category(
      description: categoryTitle,
      id: const Uuid().v4(),
      inclusion: DateTime.now(),
      selected: true,
    );
    if (categoryTitle.isNotEmpty && await _categoryService.createOrEdit(category)) {
      categories.add(category);
      categories.sort((a, b) => a.description.compareTo(b.description));
      update(["categories-list"]);
    }
    categories.refresh();
    Get.back();
  }

  onDeleteCategory(int index) async {
    bool? removeCategory;
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Tem certeza que deseja remover a categoria?",
          firstButton: () {
            removeCategory = false;
          },
          secondButton: () {
            removeCategory = true;
          },
        );
      },
    );
    if (removeCategory != null && removeCategory! && await _categoryService.deleteCategory(categories[index].id)) {
      categories.removeAt(index);
      categories.sort((a, b) => a.description.compareTo(b.description));
      allCategoriesSelected.value = categories.where((category) => category.selected).length == categories.length;
      update(["categories-list"]);
    }
  }
}
