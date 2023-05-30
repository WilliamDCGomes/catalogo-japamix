import 'package:catalago_japamix/base/services/base/base_service.dart';
import 'package:catalago_japamix/base/services/interfaces/imedia_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../base/models/media/media.dart';

class MediaService extends BaseService implements IMediaService {
  @override
  Future<bool> createOrEdit(Media media) async {
    try {
      await FirebaseFirestore.instance
          .collection("media")
          .doc()
          .set(media.toJson())
          .timeout(const Duration(seconds: 30));

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<Media>> getAll() async {
    try {
      var medias = await FirebaseFirestore.instance
          .collection("media")
          .get()
          .timeout(const Duration(seconds: 30));

      return medias.docs.map((e) => Media.fromJson(e.data())).toList();
    } catch (_) {
      return <Media>[];
    }
  }

  @override
  Future<Media?> getById(String id) async {
    try {
      var medias = await FirebaseFirestore.instance
          .collection("media")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(medias.size > 0) {
        return Media.fromJson(medias.docs.first.data());
      }
    } catch (_) {
    }
    return null;
  }

  @override
  Future<bool> deleteMedia(String id) async {
    try {
      var medias = await FirebaseFirestore.instance
          .collection("media")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(medias.size > 0) {
        for(var media in medias.docs) {
          await media
              .reference
              .delete()
              .timeout(const Duration(seconds: 30));
        }
        return true;
      }
    }
    catch(_){
    }
    return false;
  }
}
