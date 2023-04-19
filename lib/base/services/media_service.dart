import 'package:catalago_japamix/base/services/base/base_service.dart';
import '../models/media/media.dart';

class MediaService extends BaseService {
  Future<List<Media>> getAll() async {
    try {
      final response = await get('$baseUrlApi/Media/GetAll');
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Media.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<Media?> getById(String id) async {
    try {
      final response = await get('$baseUrlApi/Media/GetById', query: {"Id": id});
      if (hasErrorResponse(response)) throw Exception();
      return Media.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  Future<bool> createOrEdit(Media media) async {
    try {
      final response = await post('$baseUrlApi/Media/CreateOrEdit', media.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteMedia(String id) async {
    try {
      final response = await delete('$baseUrlApi/Media/Delete', query: {"Id": id});
      if (response.statusCode != 200) throw Exception();
      return true;
    } catch (_) {
      return false;
    }
  }
}
