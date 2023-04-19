import 'package:catalago_japamix/base/services/base/base_service.dart';
import '../models/establishmentMedia/establishment_media.dart';

class EstablishmentMediaMediaService extends BaseService {
  Future<List<EstablishmentMedia>> getAll() async {
    try {
      final response = await get('$baseUrlApi/EstablishmentMedia/GetAll');
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => EstablishmentMedia.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<EstablishmentMedia?> getById(String id) async {
    try {
      final response = await get('$baseUrlApi/EstablishmentMedia/GetById', query: {"Id": id});
      if (hasErrorResponse(response)) throw Exception();
      return EstablishmentMedia.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  Future<bool> createOrEdit(EstablishmentMedia establishmentMedia) async {
    try {
      final response = await post('$baseUrlApi/EstablishmentMedia/CreateOrEdit', establishmentMedia.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteEstablishmentMedia(String id) async {
    try {
      final response = await delete('$baseUrlApi/EstablishmentMedia/Delete', query: {"Id": id});
      if (response.statusCode != 200) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }
}
