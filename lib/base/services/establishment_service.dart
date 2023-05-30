import 'package:catalago_japamix/base/services/base/base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/establishment/establishment.dart';
import 'establishment_category_service.dart';
import 'establishment_media_service.dart';
import 'interfaces/iestablishment_category_service.dart';
import 'interfaces/iestablishment_media_service.dart';
import 'interfaces/iestablishment_service.dart';

class EstablishmentService extends BaseService implements IEstablishmentService {
  final IEstablishmentMediaService _establishmentMediaService = EstablishmentMediaService();
  final IEstablishmentCategoryService _establishmentCategoryService = EstablishmentCategoryService();

  @override
  Future<bool> createOrEdit(Establishment establishment) async {
    try {
      await FirebaseFirestore.instance
          .collection("establishment")
          .doc()
          .set(establishment.toJson())
          .timeout(const Duration(seconds: 30));

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<Establishment>> getAll() async {
    try {
      var establishments = await FirebaseFirestore.instance
          .collection("establishment")
          .get()
          .timeout(const Duration(seconds: 30));

      var allEstablishments = establishments.docs.map((e) => Establishment.fromJson(e.data())).toList();

      for(var establishment in allEstablishments) {
        establishment.establishmentMediaIds = await _establishmentMediaService.getAllEstablishmentMediaIds(establishment.id);
        establishment.categoryIds = await _establishmentCategoryService.getAllCategoryIds(establishment.id);
      }
      return allEstablishments;
    } catch (_) {
      return <Establishment>[];
    }
  }

  @override
  Future<Establishment?> getById(String id) async {
    try {
      var establishments = await FirebaseFirestore.instance
          .collection("establishment")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(establishments.size > 0) {
        return Establishment.fromJson(establishments.docs.first.data());
      }
    } catch (_) {
    }
    return null;
  }

  @override
  Future<bool> deleteEstablishment(String id) async {
    try {
      var establishments = await FirebaseFirestore.instance
          .collection("establishment")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(establishments.size > 0) {
        for(var establishment in establishments.docs) {
          await _establishmentMediaService.deleteEstablishmentMedia(establishment.data()["id"]);
          await _establishmentCategoryService.deleteEstablishmentCategory(establishment.data()["id"]);

          await establishment
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
