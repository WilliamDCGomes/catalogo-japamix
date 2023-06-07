import 'package:catalago_japamix/base/services/base/base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/banner/banners.dart';
import 'interfaces/ibanner_service.dart';

class BannerService extends BaseService implements IBannerService {
  @override
  Future<bool> create(Banners banner) async {
    try {
      await FirebaseFirestore.instance
          .collection("banner")
          .doc()
          .set(banner.toJson())
          .timeout(const Duration(seconds: 30));

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<Banners>> getAll() async {
    try {
      var banners = await FirebaseFirestore.instance
          .collection("banner")
          .get()
          .timeout(const Duration(seconds: 30));

      return banners.docs.map((e) => Banners.fromJson(e.data())).toList();
    } catch (_) {
      return <Banners>[];
    }
  }

  @override
  Future<bool> deleteBanners() async {
    try {
      var allBanners = await FirebaseFirestore.instance
          .collection("banner")
          .get()
          .timeout(const Duration(seconds: 30));

      if(allBanners.size > 0) {
        for(var banner in allBanners.docs) {
          await banner
              .reference
              .delete()
              .timeout(const Duration(seconds: 30));
        }
        return true;
      }
    }
    catch(_){
    }
    return false;
  }
}
