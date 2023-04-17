import 'package:get/get.dart';
import '../../../../base/models/places/places.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';

class DetailAdController extends GetxController {
  late Places visitPlace;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;

  DetailAdController(this.visitPlace) {
    _initializeVariables();
  }

  _initializeVariables() {
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
  }
}
