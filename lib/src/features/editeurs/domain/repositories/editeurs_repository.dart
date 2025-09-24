import '../../data/models/editeur_model.dart';

abstract class EditeursRepository {
  Future<List<EditeurModel>> getEditeurs();
  Future<EditeurModel?> getUserByEmail(String email);
  Future<bool> nommerEditeur(int userId);
  Future<bool> retirerEditeur(int userId);
}
