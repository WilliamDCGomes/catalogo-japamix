import 'package:catalago_japamix/base/services/base/base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/establishmentCategory/establishment_category.dart';
import 'interfaces/iestablishment_category_service.dart';

class EstablishmentCategoryService extends BaseService implements IEstablishmentCategoryService {
  @override
  Future<bool> createOrEdit(EstablishmentCategory establishmentCategory) async {
    try {
      await FirebaseFirestore.instance
          .collection("establishmentCategory")
          .doc()
          .set(establishmentCategory.toJson())
          .timeout(const Duration(seconds: 30));

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<EstablishmentCategory>> getAll() async {
    try {
      var establishmentCategories = await FirebaseFirestore.instance
          .collection("establishmentCategory")
          .get()
          .timeout(const Duration(seconds: 30));

      return establishmentCategories.docs.map((e) => EstablishmentCategory.fromJson(e.data())).toList();
    } catch (_) {
      return <EstablishmentCategory>[];
    }
  }

  @override
  Future<List<String>> getAllCategoryIds(String establishmentId) async {
    try {
      List<String> ids = <String>[];
      var categories = await FirebaseFirestore.instance
          .collection("establishmentCategory")
          .where("establishmentId", isEqualTo: establishmentId)
          .get()
          .timeout(const Duration(seconds: 30));

      for(var category in categories.docs) {
        var categoryId = category.data()['categoryId'];
        if(categoryId != null) {
          ids.add(categoryId);
        }
      }

      return ids;
    } catch (_) {
      return <String>[];
    }
  }

  @override
  Future<EstablishmentCategory?> getById(String id) async {
    try {
      var establishmentCategories = await FirebaseFirestore.instance
          .collection("establishmentCategory")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(establishmentCategories.size > 0) {
        return EstablishmentCategory.fromJson(establishmentCategories.docs.first.data());
      }
    } catch (_) {
    }
    return null;
  }

  @override
  Future<bool> removeCategory(String categoryId, String establishmentId) async {
    try {
      var establishmentCategories = await FirebaseFirestore.instance
          .collection("establishmentCategory")
          .where("categoryId", isEqualTo: categoryId)
          .where("establishmentId", isEqualTo: establishmentId)
          .get()
          .timeout(const Duration(seconds: 30));

      if(establishmentCategories.size > 0) {
        for(var establishmentCategory in establishmentCategories.docs) {
          await establishmentCategory
              .reference
              .delete()
              .timeout(const Duration(seconds: 30));
        }
      }
      return true;
    }
    catch(_){
      return false;
    }
  }

  @override
  Future<bool> deleteEstablishmentCategory(String establishmentId) async {
    try {
      var establishmentCategories = await FirebaseFirestore.instance
          .collection("establishmentCategory")
          .where("establishmentId", isEqualTo: establishmentId)
          .get()
          .timeout(const Duration(seconds: 30));

      if(establishmentCategories.size > 0) {
        for(var establishmentCategory in establishmentCategories.docs) {
          await establishmentCategory
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
