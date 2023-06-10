import 'package:catalago_japamix/base/services/banner_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../../base/models/banner/banners.dart';
import '../../../../base/services/interfaces/ibanner_service.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../mainMenu/page/main_menu_page.dart';

class MainMenuBannerController extends GetxController {
  late RxBool changed;
  late RxList<Banners> allBanners;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IBannerService _bannerService;

  MainMenuBannerController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _getBanners();
    super.onInit();
  }

  _initializeVariables() {
    changed = false.obs;
    allBanners = <Banners>[].obs;
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _bannerService = BannerService();
  }

  _getBanners() async {
    try {
      await loadingWithSuccessOrErrorWidget.startAnimation();

      allBanners.clear();
      allBanners.addAll(await _bannerService.getAll());

      await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
    }
    catch(_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao abrir as configurações do banner! Tente novamente mais tarde.",
          );
        },
      );
      Get.back();
    }
  }

  addBanner() async {
    try {
      if(allBanners.length == 10) {
        await showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const InformationPopup(
              warningMessage: "É permitido no máximo 10 imagens no banner.\nPara adicionar outra imagem, remova outra antes.",
            );
          },
        );
        return;
      }


      final images = await ViewPicture.addNewPicture();
      if (images != null) {
        changed.value = true;
        for(var image in images) {
          allBanners.add(
            Banners(
              base64: image,
              id: const Uuid().v4(),
              inclusion: DateTime.now(),
            ),
          );
        }
      }
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
          secondButton: () {
            changed.value = true;
            allBanners.removeAt(index);
          },
        );
      },
    );
  }

  saveBanners() async {
    try {
      await loadingWithSuccessOrErrorWidget.startAnimation();

      await _bannerService.deleteBanners();
      for(var banner in allBanners) {
        if(!await _bannerService.create(banner)) {
          throw Exception();
        }
      }

      await loadingWithSuccessOrErrorWidget.stopAnimation();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InformationPopup(
            success: true,
            warningMessage: "Banner${allBanners.isNotEmpty && allBanners.length == 1 ? " " : "s "}salvo${allBanners.isNotEmpty && allBanners.length == 1 ? " " : "s "}com sucesso!",
          );
        },
      );
      Get.offAll(() => const MainMenuPage());
    }
    catch(_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao salvar os banners, tente novamente mais tarde!",
          );
        },
      );
    }
  }
}
