import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/category/category.dart';
import '../../../../base/models/places/places.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/default_popup_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';

class MainMenuController extends GetxController {
  late TextEditingController searchByName;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late RxList<Places> visitPlaces;
  late List<Category> _categories;

  MainMenuController() {
    _initializeVariables();
  }

  _initializeVariables() {
    searchByName = TextEditingController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _categories = <Category>[
      Category(
        name: "Áreas de lazer para eventos e diversão em geral",
      ),
      Category(
        name: "Cabeleireiros e barbearias",
      ),
      Category(
        name: "Lista de delivery com a maior opção para sua fome",
      ),
      Category(
        name: "Açai, Assados, Food Truck, Sucos e Pizzarias",
      ),
      Category(
        name: "Café da Manhã",
      ),
      Category(
        name: "Salgados para festa, bolos e doces em geral",
      ),
      Category(
        name: "Restaurantes e marmitarias",
      ),
      Category(
        name: "Farmácias e Drogarias",
      ),
      Category(
        name: "Motorista de Aplicativo",
      ),
      Category(
        name: "Mototáxi, táxi e motorista de app",
      ),
      Category(
        name: "Fretes em Geral",
      ),
      Category(
        name: "Profissionais da Construção Civil",
      ),
      Category(
        name: "Manicures, pedicures e podólogas",
      ),
    ];
    visitPlaces = <Places>[
      Places(
        name: "Área de lazer JF eventos",
        phone1: "(17) 99158-6377",
        place: "Jd. das Oliveiras",
      ),
      Places(
        name: "Jd. das Oliveiras",
        phone1: "(17) 3542-4434",
        phone2: "(17) 99157-0369",
      ),
      Places(
        name: "Villa’s Eventos",
        phone1: "(17) 99635-0484",
        phone2: "(17) 3543-1248",
        place: "(17) 3542-1830",
      ),
      Places(
        name: "Falcão - JD. Falcão",
        phone1: "(17) 99200-2103",
        phone2: "(17) 98150-2199",
      ),
      Places(
        name: "Área de lazer - Recanto Família",
        phone1: "(17) 99149-0194",
        phone2: "(17) 99117-0996",
        place: "Parque do Ipês",
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
                      radioText: _categories[index].name,
                      size: 4.h,
                      checked: _categories[index].selected,
                      justRead: true,
                      onChanged: () {},
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      _categories[index].selected = !_categories[index].selected;
                      if(allCategoriesSelected && !_categories[index].selected){
                        allCategoriesSelected = _categories[index].selected;
                      }
                      else if(!allCategoriesSelected && _categories[index].selected && _categories.length == 1){
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
                    _categories.sort((a, b) => a.name.compareTo(b.name));
                    _categories.sort((a, b) => b.selected.toString().compareTo(a.selected.toString()));
                  });

                  if(_categories.where((element) => element.selected).length == _categories.length){
                    //updateList();
                  }
                  else{
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
