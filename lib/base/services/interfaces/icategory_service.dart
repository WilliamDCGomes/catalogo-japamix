import '../../models/category/category.dart';

abstract class ICategoryService {
  Future<List<Category>> getAll();
  Future<Category?> getById(String id);
  Future<bool> createOrEdit(Category category);
  Future<bool> deleteCategory(String id);
}
