import 'package:flutter/material.dart';
import 'app/enums/enums.dart';
import 'app/modules/initialPage/page/initial_page.dart';

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Catálogo Japamix DEV';
      case Flavor.hmlg:
        return 'Catálogo Japamix HMLG';
      case Flavor.prod:
        return 'Catálogo Japamix';
      default:
        return 'title';
    }
  }

  static String get extension {
    switch (appFlavor) {
      case Flavor.hmlg:
        return 'HMLG';
      case Flavor.prod:
        return 'PROD';
      default:
        return 'DEV';
    }
  }

  static bool get isDev => F.appFlavor == Flavor.dev;
  static bool get isHmlg => F.appFlavor == Flavor.hmlg;
  static bool get isProd => F.appFlavor == Flavor.prod;

  static String get baseURL {
    switch (appFlavor) {
      case Flavor.hmlg:
        return '';
      case Flavor.prod:
        return '';
      default:
        return 'http://192.168.1.35:5053/api';
    }
  }

  static Widget get initialScreen {
    switch (appFlavor) {
      case Flavor.hmlg:
        return const InitialPage();
      case Flavor.prod:
        return const InitialPage();
      default:
        return const InitialPage();
    }
  }

  static bool get isAdm {
    return false;
  }
}
