import 'package:catalago_japamix/base/services/base/base_service.dart';
import '../models/establishment/establishment.dart';
import 'interfaces/iestablishment_service.dart';

class EstablishmentService extends BaseService implements IEstablishmentService {
  @override
  Future<List<Establishment>> getAll() async {
    try {
      final response = await get('$baseUrlApi/Establishment/GetAll');
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Establishment.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<Establishment?> getById(String id) async {
    try {
      final response = await get('$baseUrlApi/Establishment/GetById', query: {"Id": id});
      if (hasErrorResponse(response)) throw Exception();
      return Establishment.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> createOrEdit(Establishment establishment) async {
    try {
      final response = await post('$baseUrlApi/Establishment/CreateOrEdit', establishment.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteEstablishment(String id) async {
    try {
      final response = await delete('$baseUrlApi/Establishment/Delete', query: {"Id": id});
      if (response.statusCode != 200) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }
}
