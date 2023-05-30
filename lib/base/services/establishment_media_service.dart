import 'package:catalago_japamix/base/services/base/base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/establishmentMedia/establishment_media.dart';
import 'interfaces/iestablishment_media_service.dart';
import 'interfaces/imedia_service.dart';
import 'media_service.dart';

class EstablishmentMediaService extends BaseService implements IEstablishmentMediaService {
  final IMediaService _mediaService = MediaService();

  @override
  Future<bool> createOrEdit(EstablishmentMedia establishmentMedia) async {
    try {
      await FirebaseFirestore.instance
          .collection("establishmentMedia")
          .doc()
          .set(establishmentMedia.toJson())
          .timeout(const Duration(seconds: 30));

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<EstablishmentMedia>> getAll() async {
    try {
      var mediasFromEstablishment = await FirebaseFirestore.instance
          .collection("establishmentMedia")
          .get()
          .timeout(const Duration(seconds: 30));

      return mediasFromEstablishment.docs.map((e) => EstablishmentMedia.fromJson(e.data())).toList();
    } catch (_) {
      return <EstablishmentMedia>[];
    }
  }

  @override
  Future<List<String>> getAllEstablishmentMediaIds(String establishmentId) async {
    try {
      List<String> ids = <String>[];
      var mediasFromEstablishment = await FirebaseFirestore.instance
          .collection("establishmentMedia")
          .where("establishmentId", isEqualTo: establishmentId)
          .get()
          .timeout(const Duration(seconds: 30));

      for(var mediaFromEstablishment in mediasFromEstablishment.docs) {
        var mediaId = mediaFromEstablishment.data()['mediaId'];
        if(mediaId != null) {
          ids.add(mediaId);
        }
      }

      return ids;
    } catch (_) {
      return <String>[];
    }
  }

  @override
  Future<EstablishmentMedia?> getById(String id) async {
    try {
      var mediasFromEstablishment = await FirebaseFirestore.instance
          .collection("establishmentMedia")
          .where("id", isEqualTo: id)
          .get()
          .timeout(const Duration(seconds: 30));

      if(mediasFromEstablishment.size > 0) {
        return EstablishmentMedia.fromJson(mediasFromEstablishment.docs.first.data());
      }
    } catch (_) {
    }
    return null;
  }

  @override
  Future<bool> deleteEstablishmentMedia(String establishmentId) async {
    try {
      var mediasFromEstablishment = await FirebaseFirestore.instance
          .collection("establishmentMedia")
          .where("establishmentId", isEqualTo: establishmentId)
          .get()
          .timeout(const Duration(seconds: 30));

      if(mediasFromEstablishment.size > 0) {
        for(var media in mediasFromEstablishment.docs) {
          await _mediaService.deleteMedia(media.data()["mediaId"]);

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
