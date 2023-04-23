import '../../../../base/models/media/media.dart';

abstract class IMediaService {
  Future<List<Media>> getAll();
  Future<Media?> getById(String id);
  Future<bool> createOrEdit(Media media);
  Future<bool> deleteMedia(String id);
}
