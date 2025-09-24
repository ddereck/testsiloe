import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;

/// An abstract class that represents a repository for the feature [RequetePriere].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [RequetePriereRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_requete_priere.dart';

abstract class RequetePriereRepository {
  Future<(Failure?, EntityRequetePriere?)> createRequetePriere({
    required String nomPrenom,
    required String contenu,
    bool anonyme = true,
  });

  Future<(Failure?, EntityRequetePriere?)> getRequetePriereById(
      {required int id});

  Future<(Failure?, List<EntityRequetePriere>)> getRequetesPriere({
    String? statut,
    bool? anonyme,
  });

  Future<(Failure?, EntityRequetePriere?)> updateRequetePriere({
    required int id,
    String? nomPrenom,
    String? contenu,
    bool? anonyme,
    String? statut,
  });

  Future<(Failure?, VoidType?)> deleteRequetePriere({required int id});

  Future<(Failure?, EntityRequetePriere?)> approuverRequetePriere(
      {required int id});

  Future<(Failure?, EntityRequetePriere?)> rejeterRequetePriere(
      {required int id});
}
