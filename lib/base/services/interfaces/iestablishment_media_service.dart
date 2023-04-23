import '../../models/establishmentMedia/establishment_media.dart';

abstract class IEstablishmentMediaService {
  Future<List<EstablishmentMedia>> getAll();
  Future<EstablishmentMedia?> getById(String id);
  Future<bool> createOrEdit(EstablishmentMedia establishmentMedia);
  Future<bool> deleteEstablishmentMedia(String id);
}
