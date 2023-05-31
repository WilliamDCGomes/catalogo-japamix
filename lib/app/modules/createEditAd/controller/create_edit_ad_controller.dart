import 'package:catalago_japamix/app/modules/categoryAd/page/category_ad_page.dart';
import 'package:catalago_japamix/app/modules/mainMenu/page/main_menu_page.dart';
import 'package:catalago_japamix/app/utils/helpers/view_picture.dart';
import 'package:catalago_japamix/base/models/category/category.dart';
import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:catalago_japamix/base/models/establishmentMedia/establishment_media.dart';
import 'package:catalago_japamix/base/services/establishment_media_service.dart';
import 'package:catalago_japamix/base/services/establishment_service.dart';
import 'package:catalago_japamix/base/services/interfaces/iestablishment_category_service.dart';
import 'package:catalago_japamix/base/services/interfaces/iestablishment_service.dart';
import 'package:catalago_japamix/base/services/interfaces/imedia_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../base/models/addressInformation/address_information.dart';
import '../../../../base/models/establishmentCategory/establishment_category.dart';
import '../../../../base/models/media/media.dart';
import '../../../../base/services/consult_cep_service.dart';
import '../../../../base/services/establishment_category_service.dart';
import '../../../../base/services/interfaces/iconsult_cep_service.dart';
import '../../../../base/services/interfaces/iestablishment_media_service.dart';
import '../../../../base/services/media_service.dart';
import '../../../utils/helpers/brazil_address_informations.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';

class CreateEditAdController extends GetxController {
  late bool newPlace;
  late Establishment? place;
  late RxString ufSelected;
  late RxBool phone1HasError;
  late RxBool phone2HasError;
  late RxBool phone3HasError;
  late RxBool cepInputHasError;
  late RxBool cityInputHasError;
  late RxBool streetInputHasError;
  late RxBool neighborhoodInputHasError;
  late RxBool nameHasError;
  late RxBool phoneItsWhatsapp;
  late FocusNode nameFocusNode;
  late FocusNode descriptionFocusNode;
  late FocusNode phone1FocusNode;
  late FocusNode phone2FocusNode;
  late FocusNode phone3FocusNode;
  late FocusNode cepFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode streetFocusNode;
  late FocusNode houseNumberFocusNode;
  late FocusNode neighborhoodFocusNode;
  late FocusNode complementFocusNode;
  late FocusNode latitudeFocusNode;
  late FocusNode longitudeFocusNode;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController phone1TextEditingController;
  late TextEditingController phone2TextEditingController;
  late TextEditingController phone3TextEditingController;
  late TextEditingController cepTextController;
  late TextEditingController cityTextController;
  late TextEditingController streetTextController;
  late TextEditingController houseNumberTextController;
  late TextEditingController neighborhoodTextController;
  late TextEditingController complementTextController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;
  late RxList<String> ufsList;
  late RxList<String> placeImages;
  late RxList<Category> categories;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IConsultCepService _consultCepService;
  late final IEstablishmentService _establishmentService;
  late final IEstablishmentMediaService _establishmentMediaService;
  late final IMediaService _mediaService;
  late final IEstablishmentCategoryService _establishmentCategoryService;

  CreateEditAdController(this.place, List<Category> categories) {
    _initializeVariables(categories);
    _getUfsNames();
  }

  _initializeVariables(List<Category> categoriesList) {
    newPlace = place == null;
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    ufSelected = "".obs;
    phone1HasError = false.obs;
    phone2HasError = false.obs;
    phone3HasError = false.obs;
    cepInputHasError = false.obs;
    cityInputHasError = false.obs;
    streetInputHasError = false.obs;
    neighborhoodInputHasError = false.obs;
    nameHasError = false.obs;
    phoneItsWhatsapp = place?.primaryTelephoneIsWhatsapp == null ? false.obs : place!.primaryTelephoneIsWhatsapp.obs;
    nameFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    phone1FocusNode = FocusNode();
    phone2FocusNode = FocusNode();
    phone3FocusNode = FocusNode();
    cepFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    streetFocusNode = FocusNode();
    houseNumberFocusNode = FocusNode();
    neighborhoodFocusNode = FocusNode();
    complementFocusNode = FocusNode();
    latitudeFocusNode = FocusNode();
    longitudeFocusNode = FocusNode();
    nameController = TextEditingController(
      text: place?.name ?? "",
    );
    descriptionController = TextEditingController(text: place?.description ?? "");
    phone1TextEditingController = TextEditingController(text: place?.primaryTelephone ?? "");
    phone2TextEditingController = TextEditingController(text: place?.secondaryTelephone ?? "");
    phone3TextEditingController = TextEditingController(text: place?.tertiaryTelephone ?? "");
    cepTextController = TextEditingController(text: place?.cep ?? "");
    cityTextController = TextEditingController(text: place?.city ?? "");
    streetTextController = TextEditingController(text: place?.address ?? "");
    houseNumberTextController = TextEditingController(text: place?.number ?? "");
    neighborhoodTextController = TextEditingController(text: place?.district ?? "");
    complementTextController = TextEditingController(text: place?.complement ?? "");
    latitudeController = TextEditingController(text: place?.latitude ?? "");
    longitudeController = TextEditingController(text: place?.longitude ?? "");
    placeImages = (place?.imagesPlace.isEmpty ?? true ? <String>[] : place!.imagesPlace).obs;
    ufsList = <String>[].obs;
    categories = <Category>[].obs;
    for (var category in categoriesList) {
      category.selected = false;
      final categoryToAdd = category.copyWith(category);
      if (place != null && place!.categoryIds != null && place!.categoryIds!.contains(categoryToAdd.id)) {
        categoryToAdd.selected = true;
      }
      categories.add(categoryToAdd);
    }
    _consultCepService = ConsultCepService();
    _establishmentService = EstablishmentService();
    _establishmentMediaService = EstablishmentMediaService();
    _mediaService = MediaService();
    _establishmentCategoryService = EstablishmentCategoryService();
  }

  _getUfsNames() async {
    try {
      ufsList.clear();
      List<String> states = await BrazilAddressInformations.getUfsNames();
      for (var uf in states) {
        ufsList.add(uf);
      }
    } catch (_) {
      ufsList.clear();
    } finally {
      if (place?.state != null) ufSelected.value = place?.state ?? "";
    }
  }

  searchAddressInformation() async {
    try {
      if (cepTextController.text.length == 9) {
        AddressInformation? addressInformation = await _consultCepService.searchCep(cepTextController.text);
        if (addressInformation != null) {
          ufSelected.value = addressInformation.uf;
          cityTextController.text = addressInformation.localidade;
          streetTextController.text = addressInformation.logradouro;
          neighborhoodTextController.text = addressInformation.bairro;
          complementTextController.text = addressInformation.complemento;
        } else {
          throw Exception();
        }
      }
    } catch (_) {
      ufSelected.value = "";
      cityTextController.text = "";
      streetTextController.text = "";
      neighborhoodTextController.text = "";
      complementTextController.text = "";
    }
  }

  addNewPicture() async {
    try {
      final image = await ViewPicture.addNewPicture();
      if (image != null && image.isNotEmpty) placeImages.addAll(image);
    } catch (_) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Não foi possível adicionar a imagem",
          );
        },
      );
    }
  }

  removePicture(int index) async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Tem certeza que deseja remover a imagem?",
          firstButton: () {},
          secondButton: () => placeImages.removeAt(index),
        );
      },
    );
  }

  openCatories() async {
    var result = await Get.to(() => CategoryAdPage(categories: categories));
    if (result != null && (result.runtimeType == RxList<Category>) && (result as RxList).isNotEmpty) {
      categories = (result as RxList<Category>);
    }
  }

  bool verifyFields(){
    try{
      if(nameController.text.isEmpty){
        throw Exception("Informe o nome do anúncio!");
      }
      else if(phone1TextEditingController.text.isEmpty && phone2TextEditingController.text.isEmpty && phone3TextEditingController.text.isEmpty){
        throw Exception("Informe ao menos um telefone de contato!");
      }
      else if (!categories.any((category) => category.selected)) {
        throw Exception("Selecione ao menos uma categoria para o anúncio!");
      }

      return true;
    }
    catch(e){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return InformationPopup(
            warningMessage: e.toString().replaceAll("Exception: ", ""),
          );
        },
      );
      return false;
    }
  }

  addNewAd() async {
    try {
      if(!verifyFields()) return;

      loadingWithSuccessOrErrorWidget.startAnimation();
      if(!newPlace && place != null && place!.id.isNotEmpty) {
        await _establishmentService.deleteEstablishment(place!.id);
      }

      final establishment = Establishment(
        id: place?.id ?? const Uuid().v4(),
        name: nameController.text,
        description: descriptionController.text,
        primaryTelephone: phone1TextEditingController.text,
        secondaryTelephone: phone2TextEditingController.text,
        tertiaryTelephone: phone3TextEditingController.text,
        cep: cepTextController.text,
        state: ufSelected.value,
        city: cityTextController.text,
        address: streetTextController.text,
        number: houseNumberTextController.text,
        district: neighborhoodTextController.text,
        latitude: latitudeController.text,
        longitude: longitudeController.text,
        complement: complementTextController.text,
        primaryTelephoneIsWhatsapp: phoneItsWhatsapp.value,
      );
      final createEstablishment = await _establishmentService.createOrEdit(establishment);
      if (!createEstablishment) throw Exception();
      bool createImage = true;
      if (place != null) {
        for (String image in (place!.establishmentMediaIds ?? [])) {
          await _mediaService.deleteMedia(image);
        }
      }
      for (var imageBase64 in placeImages) {
        final media = Media(
          base64: imageBase64,
          name: null,
          extension: MediaExtension.jpeg,
          id: const Uuid().v4(),
        );
        bool createImageUnique = await _mediaService.createOrEdit(media);
        createImageUnique = await _establishmentMediaService.createOrEdit(
          EstablishmentMedia(
            establishmentId: establishment.id,
            mediaId: media.id,
            main: false,
            id: const Uuid().v4(),
          ),
        );
        createImage = createImageUnique;
      }
      if (!createImage) throw Exception();
      if (place != null) {
        establishment.imagesPlace = placeImages;
      }
      bool createCategory = true;
      if (place != null) {
        for (String category in (place!.categoryIds ?? [])) {
          await _establishmentCategoryService.deleteEstablishmentCategory(category);
        }
      }
      for (var category in categories) {
        if(category.selected){
          createCategory = await _establishmentCategoryService.createOrEdit(
            EstablishmentCategory(
              establishmentId: establishment.id,
              categoryId: category.id,
              id: const Uuid().v4(),
            ),
          );
        }
        else{
          createCategory = await _establishmentCategoryService.removeCategory(
            category.id,
            establishment.id,
          );
        }
      }
      if (!createCategory) throw Exception();
      //await Get.find<MainMenuController>().getPlaces();

      await loadingWithSuccessOrErrorWidget.stopAnimation();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InformationPopup(
            warningMessage: "Anúncio ${newPlace ? "salvo" : "atualizado"} com sucesso!",
          );
        },
      );
      Get.offAll(() => const MainMenuPage());
    } catch (_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InformationPopup(
            warningMessage: "Erro ao ${newPlace ? "salvar" : "atualizar"} o anúncio!\nTente novamente mais tarde.",
          );
        },
      );
    }
  }
}
