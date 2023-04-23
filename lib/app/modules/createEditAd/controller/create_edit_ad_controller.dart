import 'package:catalago_japamix/app/modules/mainMenu/controller/main_menu_controller.dart';
import 'package:catalago_japamix/app/utils/helpers/view_picture.dart';
import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:catalago_japamix/base/services/establishment_service.dart';
import 'package:catalago_japamix/base/services/interfaces/iestablishment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../base/models/addressInformation/address_information.dart';
import '../../../../base/services/consult_cep_service.dart';
import '../../../../base/services/interfaces/iconsult_cep_service.dart';
import '../../../utils/helpers/brazil_address_informations.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';

class CreateEditAdController extends GetxController {
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
  late RxList<XFile> placeImages;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IConsultCepService _consultCepService;
  late final IEstablishmentService _establishmentService;

  CreateEditAdController(this.place) {
    _initializeVariables();
    _getUfsNames();
  }

  _initializeVariables() {
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
    phoneItsWhatsapp = false.obs;
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
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    phone1TextEditingController = TextEditingController();
    phone2TextEditingController = TextEditingController();
    phone3TextEditingController = TextEditingController();
    cepTextController = TextEditingController();
    cityTextController = TextEditingController();
    streetTextController = TextEditingController();
    houseNumberTextController = TextEditingController();
    neighborhoodTextController = TextEditingController();
    complementTextController = TextEditingController();
    latitudeController = TextEditingController();
    longitudeController = TextEditingController();
    placeImages = <XFile>[].obs;
    ufsList = <String>[].obs;
    _consultCepService = ConsultCepService();
    _establishmentService = EstablishmentService();
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
      if (image != null) placeImages.add(image);
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
          subTitle: "Tem certeza que deseja remover a imagem",
          firstButton: () {},
          secondButton: () => placeImages.removeAt(index),
        );
      },
    );
  }

  void saveEstablishment() async {
    final establishment = Establishment(
      id: const Uuid().v4(),
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
      categoryId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    );
    final createEstablishment = await _establishmentService.createOrEdit(establishment);
    if (createEstablishment) {
      Get.find<MainMenuController>().getPlaces();
      Get.back();
    }
  }
}
