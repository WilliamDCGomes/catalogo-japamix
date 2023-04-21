import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';
import '../../../../base/models/category/category.dart';
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
  late List<Category> _categories;

  MainMenuController() {
    _initializeVariables();
  }

  _initializeVariables() {
    searchByName = TextEditingController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _categories = <Category>[
      Category(
        id: const Uuid().v4(),
        description: "Áreas de lazer para eventos e diversão em geral",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Cabeleireiros e barbearias",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Lista de delivery com a maior opção para sua fome",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Açai, Assados, Food Truck, Sucos e Pizzarias",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Café da Manhã",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Salgados para festa, bolos e doces em geral",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Restaurantes e marmitarias",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Farmácias e Drogarias",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Motorista de Aplicativo",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Mototáxi, táxi e motorista de app",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Fretes em Geral",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Profissionais da Construção Civil",
      ),
      Category(
        id: const Uuid().v4(),
        description: "Manicures, pedicures e podólogas",
      ),
    ];
    visitPlaces = <Establishment>[
      Establishment(
        name: "Área de lazer JF eventos Completo",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris velit ligula, auctor vitae congue a, semper efficitur arcu. Donec vulputate aliquam augue, a imperdiet lacus volutpat ac. Nulla at augue quis diam viverra luctus nec eu massa. Vestibulum elementum arcu nulla, fermentum luctus diam malesuada vel. Aenean vel purus laoreet, aliquet urna at, pulvinar ligula. Etiam auctor odio mattis ipsum sagittis imperdiet. Suspendisse potenti. Duis quis tempus diam. In felis orci, vehicula eu dignissim ut, condimentum non tellus.",
        primaryTelephone: "(17) 99158-6377",
        secondaryTelephone: "(17) 99234-9875",
        tertiaryTelephone: "(17) 98234-2835",
        address: "Jd. das Oliveiras",
        imagesPlace: [
          Paths.backgroundImage,
          Paths.backgroundImage,
          Paths.backgroundImage,
          Paths.backgroundImage,
          Paths.backgroundImage,
        ],
        categoryId: "",
        city: "",
        district: "",
        id: "",
        latitude: "",
        longitude: "",
        number: "",
        state: "",
      ),
      Establishment(
        name: "Área de lazer JF eventos",
        primaryTelephone: "(17) 99158-6377",
        address: "Jd. das Oliveiras",
        description: "",
        secondaryTelephone: "",
        tertiaryTelephone: "",
        imagesPlace: [],
        categoryId: "",
        city: "",
        district: "",
        id: "",
        latitude: "",
        longitude: "",
        number: "",
        state: "",
      ),
      Establishment(
        name: "Jd. das Oliveiras",
        primaryTelephone: "(17) 3542-4434",
        secondaryTelephone: "(17) 99157-0369",
        description: "",
        address: "",
        tertiaryTelephone: "",
        imagesPlace: [],
        categoryId: "",
        city: "",
        district: "",
        id: "",
        latitude: "",
        longitude: "",
        number: "",
        state: "",
      ),
    ].obs;
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
