import 'package:catalago_japamix/base/services/base/base_service.dart';
import '../models/establishmentCategory/establishment_category.dart';
import 'interfaces/iestablishment_category_service.dart';

class EstablishmentCategoryService extends BaseService implements IEstablishmentCategoryService {
  @override
  Future<List<EstablishmentCategory>> getAll() async {
    try {
      final response = await get('$baseUrlApi/EstablishmentCategory/GetAll');
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => EstablishmentCategory.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<EstablishmentCategory?> getById(String id) async {
    try {
      final response = await get('$baseUrlApi/EstablishmentCategory/GetById', query: {"Id": id});
      if (hasErrorResponse(response)) throw Exception();
      return EstablishmentCategory.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> createOrEdit(EstablishmentCategory establishmentCategory) async {
    try {
      final response = await post('$baseUrlApi/EstablishmentCategory/CreateOrEdit', establishmentCategory.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteEstablishmentCategory(String id) async {
    try {
      final response = await delete('$baseUrlApi/EstablishmentCategory/Delete', query: {"Id": id});
      if (response.statusCode != 200) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }
}
