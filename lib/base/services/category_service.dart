import 'package:catalago_japamix/base/services/base/base_service.dart';
import '../models/category/category.dart';

class CategoryService extends BaseService {
  Future<List<Category>> getAll() async {
    try {
      final response = await get('$baseUrlApi/Category/GetAll');
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Category.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<Category?> getById(String id) async {
    try {
      final response = await get('$baseUrlApi/Category/GetById', query: {"Id": id});
      if (hasErrorResponse(response)) throw Exception();
      return Category.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  Future<bool> createOrEdit(Category category) async {
    try {
      final response = await post('$baseUrlApi/Category/CreateOrEdit', category.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      final response = await delete('$baseUrlApi/Category/Delete', query: {"Id": id});
      if (response.statusCode != 200) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }
}
