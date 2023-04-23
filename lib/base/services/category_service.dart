import 'package:catalago_japamix/base/services/base/base_service.dart';
import 'package:catalago_japamix/base/services/interfaces/icategory_service.dart';
import '../models/category/category.dart';

class CategoryService extends BaseService implements ICategoryService {
  @override
  Future<List<Category>> getAll() async {
    try {
      final response = await get('$baseUrlApi/Category/GetAll');
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Category.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<Category?> getById(String id) async {
    try {
      final response = await get('$baseUrlApi/Category/GetById', query: {"Id": id});
      if (hasErrorResponse(response)) throw Exception();
      return Category.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> createOrEdit(Category category) async {
    try {
      final response = await post('$baseUrlApi/Category/CreateOrEdit', category.toJson());
      if (response.statusCode != 200) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
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
