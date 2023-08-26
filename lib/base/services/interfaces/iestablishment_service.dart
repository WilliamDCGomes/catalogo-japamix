import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/establishment/establishment.dart';

abstract class IEstablishmentService {
  Future<List<Establishment>> getAll(List<QueryDocumentSnapshot<Map<String, dynamic>>>? establishmentsSend);
  Future<Establishment?> getById(String id);
  Future<bool> createOrEdit(Establishment establishment);
  Future<bool> deleteEstablishment(String id);
}
