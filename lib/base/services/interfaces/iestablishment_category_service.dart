import '../../models/establishmentCategory/establishment_category.dart';

abstract class IEstablishmentCategoryService {
  Future<List<EstablishmentCategory>> getAll();
  Future<EstablishmentCategory?> getById(String id);
  Future<bool> createOrEdit(EstablishmentCategory establishment);
  Future<bool> removeCategory(String categoryId, String establishmentId);
  Future<bool> deleteEstablishmentCategory(String id);
}
