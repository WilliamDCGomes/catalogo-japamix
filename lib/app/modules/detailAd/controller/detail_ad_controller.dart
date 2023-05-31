import 'package:catalago_japamix/base/services/establishment_service.dart';
import 'package:catalago_japamix/base/services/interfaces/iestablishment_service.dart';
import 'package:catalago_japamix/base/services/interfaces/imedia_service.dart';
import 'package:catalago_japamix/base/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/models/establishment/establishment.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../mainMenu/page/main_menu_page.dart';

class DetailAdController extends GetxController {
  late Establishment visitPlace;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late final IMediaService _mediaService;

  DetailAdController(this.visitPlace) {
    _initializeVariables();
  }

  @override
  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _getImages();
    super.onInit();
  }

  _initializeVariables() {
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _mediaService = MediaService();
  }

  _getImages() async {
    try{
      await loadingWithSuccessOrErrorWidget.startAnimation();
      visitPlace.imagesPlace.clear();
      for (var element in (visitPlace.establishmentMediaIds ?? [])) {
        final media = await _mediaService.getById(element);
        if (media != null) visitPlace.imagesPlace.add(media.base64);
      }
      update(['imagem']);
      await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao abrir esse anúncio! Tente novamente mais tarde.",
          );
        },
      );
      Get.back();
    }
  }

  deleteAd() async {
    try{
      await loadingWithSuccessOrErrorWidget.startAnimation();
      IEstablishmentService establishmentService = EstablishmentService();
      establishmentService.deleteEstablishment(visitPlace.id);

      await loadingWithSuccessOrErrorWidget.stopAnimation();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Anúncio apagado com sucesso!",
          );
        },
      );
      Get.offAll(() => const MainMenuPage());
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao apagar o anúncio! Tente novamente mais tarde.",
          );
        },
      );
    }
  }
}
