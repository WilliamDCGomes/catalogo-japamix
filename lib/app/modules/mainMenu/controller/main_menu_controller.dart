import 'package:catalago_japamix/base/services/interfaces/icategory_service.dart';
import 'package:catalago_japamix/base/services/interfaces/iestablishment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/category/category.dart';
import '../../../../base/services/category_service.dart';
import '../../../../base/services/establishment_service.dart';
import '../../../../base/services/interfaces/imedia_service.dart';
import '../../../../base/services/media_service.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/category_ad_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/default_popup_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../createEditAd/page/create_edit_ad_page.dart';
import '../widgets/place_card_widget.dart';

class MainMenuController extends GetxController {
  late bool allCategoriesSelected;
  late TextEditingController searchByName;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late RxList<PlaceCardWidget> _visitPlaces;
  late RxList<Category> _categories;
  late final IEstablishmentService _establishmentService;
  late final ICategoryService _categoryService;
  late final IMediaService _mediaService;

  MainMenuController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    _initializeMethods();
    super.onInit();
  }

  _initializeVariables() {
    allCategoriesSelected = true;
    searchByName = TextEditingController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _establishmentService = EstablishmentService();
    _categoryService = CategoryService();
    _mediaService = MediaService();
    _categories = <Category>[].obs;
    _visitPlaces = <PlaceCardWidget>[].obs;
  }

  _initializeMethods() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await loadingWithSuccessOrErrorWidget.startAnimation();
    await getCategories();
    await getPlaces();

    if(_visitPlaces.isNotEmpty){
      _getFirstImage();
    }
    await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
  }

  //Getters
  List<Category> get categories => _categories;
  List<PlaceCardWidget> get visitPlaces {
    List<String> selectedCategories = _categories.where((p0) => p0.selected).map((e) => e.id).toList();
    List<PlaceCardWidget> allVisitPlace = <PlaceCardWidget>[];

    for(var category in selectedCategories){
      for(var place in _visitPlaces){
        if(place.place.categoryIds == null) break;
        if(place.place.categoryIds!.contains(category) && !allVisitPlace.map((e) => e.place.id).toList().contains(place.place.id)) allVisitPlace.add(place);
      }
    }

    return allVisitPlace;
  }

  Future<void> getCategories() async {
    try {
      _categories.value = [];
      _categories.value = await _categoryService.getAll();
    } catch (_) {
      _categories.value = [];
    } finally {
      for (var category in _categories) {
        category.selected = true;
      }
      _categories.sort((a, b) => a.description.compareTo(b.description));
    }
  }

  Future<void> getPlaces() async {
    try {
      _visitPlaces.value = [];
      var places = await _establishmentService.getAll();

      for(var place in places) {
        place.categoryName = _categories.firstWhere((category) => place.categoryIds!.contains(category.id)).description;
        _visitPlaces.add(
          PlaceCardWidget(
            place: place,
            categories: _categories,
          ),
        );
      }
    } catch (_) {
      _visitPlaces.value = [];
    }
  }

  _getFirstImage() async {
    var listVisitPlaces = _visitPlaces;
    listVisitPlaces.sort((a, b) => a.place.name.compareTo(b.place.name));
    listVisitPlaces.sort((a, b) => a.place.categoryName.compareTo(b.place.categoryName));
    for(var visitPlace in listVisitPlaces){
      if((visitPlace.place.establishmentMediaIds ?? []).isNotEmpty) {
        final media = await _mediaService.getById(visitPlace.place.establishmentMediaIds!.first);
        if (media != null) {
          visitPlace.place.imagesPlace.value = [media.base64];
        }
      }
      visitPlace.loading.value = false;
    }
  }

  openFilter() async {
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
                itemBuilder: (context, index) => CategoryAdWidget(
                  category: _categories[index],
                  disableStyle: true,
                  onTap: () async {
                    setState(() {
                      _categories[index].selected = !_categories[index].selected;
                      if (allCategoriesSelected && !_categories[index].selected) {
                        allCategoriesSelected = _categories[index].selected;
                      } else {
                        allCategoriesSelected =
                            (!allCategoriesSelected && _categories[index].selected && _categories.length == 1) ||
                                (!allCategoriesSelected &&
                                    _categories.where((category) => category.selected).length == _categories.length);
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

                  // if (_categories.where((element) => element.selected).length == _categories.length) {

                  // } else {

                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  addAd() async {
    var result = await Get.to(() => CreateEditAdPage(categories: _categories));

    if (result != null && result.runtimeType == RxList && (result as RxList).isNotEmpty) {
      await _initializeMethods();
    }
  }
}
