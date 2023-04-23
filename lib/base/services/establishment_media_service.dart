import 'package:catalago_japamix/base/services/base/base_service.dart';
import '../models/establishmentMedia/establishment_media.dart';
import 'interfaces/iestablishment_media_service.dart';

class EstablishmentMediaService extends BaseService implements IEstablishmentMediaService {
  @override
  Future<List<EstablishmentMedia>> getAll() async {
    try {
      final response = await get('$baseUrlApi/EstablishmentMedia/GetAll');
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => EstablishmentMedia.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<EstablishmentMedia?> getById(String id) async {
    try {
      final response = await get('$baseUrlApi/EstablishmentMedia/GetById', query: {"Id": id});
      if (hasErrorResponse(response)) throw Exception();
      return EstablishmentMedia.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> createOrEdit(EstablishmentMedia establishmentMedia) async {
    try {
      final response = await post('$baseUrlApi/EstablishmentMedia/CreateOrEdit', establishmentMedia.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
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
