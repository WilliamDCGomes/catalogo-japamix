import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/category/category.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/category_ad_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/default_popup_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../createEditAd/page/create_edit_ad_page.dart';

class MainMenuController extends GetxController {
  late bool allCategoriesSelected;
  late TextEditingController searchByName;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late RxList<Establishment> visitPlaces;
  late List<Category> categories;

  MainMenuController() {
    _initializeVariables();
  }

  _initializeVariables() {
    allCategoriesSelected = true;
    searchByName = TextEditingController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    categories = <Category>[
      Category(
        name: "Áreas de lazer para eventos e diversão em geral",
        selected: true,
      ),
      Category(
        name: "Cabeleireiros e barbearias",
        selected: true,
      ),
      Category(
        name: "Lista de delivery com a maior opção para sua fome",
        selected: true,
      ),
      Category(
        name: "Açai, Assados, Food Truck, Sucos e Pizzarias",
        selected: true,
      ),
      Category(
        name: "Café da Manhã",
        selected: true,
      ),
      Category(
        name: "Salgados para festa, bolos e doces em geral",
        selected: true,
      ),
      Category(
        name: "Restaurantes e marmitarias",
        selected: true,
      ),
      Category(
        name: "Farmácias e Drogarias",
        selected: true,
      ),
      Category(
        name: "Motorista de Aplicativo",
        selected: true,
      ),
      Category(
        name: "Mototáxi, táxi e motorista de app",
        selected: true,
      ),
      Category(
        name: "Fretes em Geral",
        selected: true,
      ),
      Category(
        name: "Profissionais da Construção Civil",
        selected: true,
      ),
      Category(
        name: "Manicures, pedicures e podólogas",
        selected: true,
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
                  for (var user in categories) {
                    user.selected = allCategoriesSelected;
                  }
                });
              },
            ),
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                itemCount: categories.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => CategoryAdWidget(
                  category: categories[index],
                  disableStyle: true,
                  onTap: () async {
                    setState(() {
                      categories[index].selected = !categories[index].selected;
                      if(allCategoriesSelected && !categories[index].selected){
                        allCategoriesSelected = categories[index].selected;
                      }
                      else {
                        allCategoriesSelected = (!allCategoriesSelected && categories[index].selected && categories.length == 1) ||
                            (!allCategoriesSelected && categories.where((category) => category.selected).length == categories.length);
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
                    categories.sort((a, b) => a.name.compareTo(b.name));
                    categories.sort((a, b) => b.selected.toString().compareTo(a.selected.toString()));
                  });

                  if (categories.where((element) => element.selected).length == categories.length) {
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

  addAd() async {
    var result = Get.to(() => CreateEditAdPage(categories: categories));

    if(result != null && result.runtimeType == RxList && (result as RxList).isNotEmpty){
      categories = (result as List<Category>);
    }
  }
}
