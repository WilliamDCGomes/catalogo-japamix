import 'package:catalago_japamix/app/modules/detailAd/page/detail_ad_page.dart';
import 'package:catalago_japamix/base/services/interfaces/icategory_service.dart';
import 'package:catalago_japamix/base/services/interfaces/iestablishment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uni_links/uni_links.dart';
import '../../../../base/models/category/category.dart';
import '../../../../base/models/establishment/establishment.dart';
import '../../../../base/services/category_service.dart';
import '../../../../base/services/establishment_service.dart';
import '../../../../base/services/interfaces/imedia_service.dart';
import '../../../../base/services/media_service.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/category_ad_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/default_popup_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
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

    await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
  }

  //Getters
  List<Category> get categories => _categories;
  List<PlaceCardWidget> get visitPlaces {
    List<String> selectedCategories = _categories.where((p0) => p0.selected).map((e) => e.id).toList();
    List<PlaceCardWidget> allVisitPlace = <PlaceCardWidget>[];
    List<PlaceCardWidget> allPlaceSeparateByCategory = <PlaceCardWidget>[];

    for (var category in selectedCategories) {
      for (var place in _visitPlaces) {
        if (place.place.categoryIds == null) break;
        if (place.place.categoryIds!.contains(category) &&
            !allVisitPlace.map((e) => e.place.id).toList().contains(place.place.id)) allVisitPlace.add(place);
      }
    }

    for (var place in allVisitPlace) {
      for (var category in place.place.categoryIds!) {
        if (selectedCategories.contains(category)) {
          var newPlace = PlaceCardWidget(
            place: Establishment.fromJson(place.place.toJson()),
            categories: _categories,
          );
          newPlace.place.categoryId = category;
          newPlace.place.imagesPlace = _visitPlaces.firstWhere((p0) => p0.place.id == newPlace.place.id).place.imagesPlace;
          newPlace.loading.value = false;
          allPlaceSeparateByCategory.add(newPlace);
        }
      }
    }

    return allPlaceSeparateByCategory;
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

      for (var place in places) {
        place.categoryName = _categories.firstWhere((category) => place.categoryIds!.contains(category.id)).description;
        // var image = await _getFirstImage(place.establishmentMediaIds!.first);
        // if (image.isEmpty && place.establishmentMediaIds!.length > 1) {
        //   image = await _getFirstImage(place.establishmentMediaIds![1]);
        // }
        // place.imagesPlace.add(image);
        _visitPlaces.add(
          PlaceCardWidget(
            place: place,
            categories: _categories,
          ),
        );
      }
    } catch (_) {
      _visitPlaces.value = [];
    } finally {
      processLink();
    }
  }

  Future<void> processLink() async {
    // Obtém o link que abriu o aplicativo
    final initialLink = await getInitialLink();

    try {
      // Verifica se o link não é nulo e corresponde ao esquema de URL personalizado do seu aplicativo
      //compartilharlink://estabelecimento?id=9dc8ddc3-51be-47a1-aae5-bae3df4dd228
      if (initialLink != null && initialLink.contains('compartilharlink')) {
        // Extraia os parâmetros, se houver
        // final Uri linkUri = Uri.parse(initialLink);
        String id = initialLink.substring(32);

        // Obtenha os parâmetros específicos da URL, como a tela e os valores dos parâmetros
        // final String id = linkUri.queryParameters['id']!;
        final visitPlace = _visitPlaces.firstWhereOrNull((element) => element.place.id == id);

        if (visitPlace == null) {
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const InformationPopup(
                warningMessage: "Não foi possível encontrar o estabelecimento que você está procurando.",
              );
            },
          );
        }
        // Navegue para a tela apropriada com base nos parâmetros recebidos
        // Por exemplo, usando um roteador de navegação (como o `Navigator` do Flutter)
        if (visitPlace != null) {
          Get.to(() => DetailAdPage(establishment: visitPlace.place, categories: visitPlace.categories));
        }
        // Adicione mais condições para outras telas que você deseja suportar
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> _getFirstImage(String mediaId) async {
    try {
      if (mediaId.isNotEmpty) {
        final media = await _mediaService.getById(mediaId);
        if (media != null) {
          return media.base64;
        }
      }
    } catch (_) {}
    return "";
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
