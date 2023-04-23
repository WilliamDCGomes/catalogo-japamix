import 'package:catalago_japamix/base/services/interfaces/imedia_service.dart';
import 'package:catalago_japamix/base/services/media_service.dart';
import 'package:get/get.dart';
import '../../../../base/models/establishment/establishment.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';

class DetailAdController extends GetxController {
  late Establishment visitPlace;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late final IMediaService _mediaService;

  DetailAdController(this.visitPlace) {
    _initializeVariables();
    getImages();
  }

  _initializeVariables() {
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _mediaService = MediaService();
  }

  getImages() async {
    visitPlace.imagesPlace.clear();
    for (var element in (visitPlace.establishmentMediaIds ?? [])) {
      final media = await _mediaService.getById(element);
      if (media != null) visitPlace.imagesPlace.add(media.base64);
    }
    update(['imagem']);
  }
}
