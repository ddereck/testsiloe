import '../../domain/repositories/editeurs_repository.dart';
import '../../data/models/editeur_model.dart';
import '../../data/data_sources/editeurs_data_source.dart';

class EditeursRepositoryImpl implements EditeursRepository {
  final EditeursDataSource dataSource;

  EditeursRepositoryImpl({required this.dataSource});

  @override
  Future<List<EditeurModel>> getEditeurs() async {
    return await dataSource.getEditeurs();
  }

  @override
  Future<EditeurModel?> getUserByEmail(String email) async {
    return await dataSource.getUserByEmail(email);
  }

  @override
  Future<bool> nommerEditeur(int userId) async {
    return await dataSource.nommerEditeur(userId);
  }

  @override
  Future<bool> retirerEditeur(int userId) async {
    return await dataSource.retirerEditeur(userId);
  }
}
