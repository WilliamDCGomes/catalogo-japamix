import '../../models/establishment/establishment.dart';

abstract class IEstablishmentService {
  Future<List<Establishment>> getAll();
  Future<Establishment?> getById(String id);
  Future<bool> createOrEdit(Establishment establishment);
  Future<bool> deleteEstablishment(String id);
}
