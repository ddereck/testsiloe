import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [Categorie].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [CategorieRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_categorie.dart';

abstract class CategorieRepository {
  Future<(Failure?, List<EntityCategorie>)> getAllCategories(
      {String? search, int perPage = 20});

  Future<(Failure?, EntityCategorie?)> getCategorieById({required int id});

  Future<(Failure?, EntityCategorie?)> createCategorie({required String nomCategorie});

  Future<(Failure?, EntityCategorie?)> updateCategorie(
      {required int id, required String nomCategorie});

  Future<(Failure?, VoidType?)> deleteCategorie({required int id});
}
