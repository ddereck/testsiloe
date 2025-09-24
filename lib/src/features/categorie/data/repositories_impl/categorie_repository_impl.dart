import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_categorie.dart';
import '../../domain/repositories/categorie_repository.dart';
import '../data_sources/categorie_data_source.dart';

/// A class that implements [CategorieRepository].
///
/// The class is named [CategorieRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class CategorieRepositoryImpl implements CategorieRepository {

  final CategorieDataSource dataSource;
  const CategorieRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, EntityCategorie?)> createCategorie({required String nomCategorie}) async {
    try {
      final result = await dataSource.createCategorie(nomCategorie: nomCategorie);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deleteCategorie({required int id}) async {
    try {
      await dataSource.deleteCategorie(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityCategorie>)> getAllCategories({String? search, int perPage = 20}) async {
    try {
      final result = await dataSource.getAllCategories(search: search, perPage: perPage);
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityCategorie?)> getCategorieById({required int id}) async {
    try {
      final result = await dataSource.getCategorieById(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityCategorie?)> updateCategorie({required int id, required String nomCategorie}) async {
    try {
      final result = await dataSource.updateCategorie(id: id, nomCategorie: nomCategorie);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

}
