import 'package:catalago_japamix/base/services/base/base_service.dart';
import 'package:catalago_japamix/base/services/interfaces/icategory_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category/category.dart';

class CategoryService extends BaseService implements ICategoryService {
  @override
  Future<bool> createOrEdit(Category category) async {
    try {
      await FirebaseFirestore.instance
          .collection("category")
          .doc()
          .set(category.toJson())
          .timeout(const Duration(seconds: 30));

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<Category>> getAll() async {
    try {
      var categories = await FirebaseFirestore.instance
          .collection("category")
          .get()
          .timeout(const Duration(seconds: 30));

      return categories.docs.map((e) => Category.fromJson(e.data())).toList();
    } catch (_) {
      return <Category>[];
    }
  }

  @override
  Future<Category?> getById(String id) async {
    try {
      var categories = await FirebaseFirestore.instance
          .collection("category")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(categories.size > 0) {
        return Category.fromJson(categories.docs.first.data());
      }
    } catch (_) {
    }
    return null;
  }

  @override
  Future<bool> deleteCategory(String id) async {
    try {
      var categories = await FirebaseFirestore.instance
          .collection("category")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(categories.size > 0) {
        for(var category in categories.docs) {
          await category
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
