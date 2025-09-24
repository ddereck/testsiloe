import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [DemandeRencontre].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [DemandeRencontreRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_demande_rencontre.dart';

abstract class DemandeRencontreRepository {
  Future<(Failure?, List<EntityDemandeRencontre>)> getDemandes(
      {String? statut, int? utilisateurId});

  Future<(Failure?, List<EntityDemandeRencontre>)> getMesDemandes();

  Future<(Failure?, EntityDemandeRencontre?)> createDemandeRencontre({
    required String nomPrenoms,
    required String email,
    required String telephone,
    required String date,
    required String objet,
  });

  Future<(Failure?, EntityDemandeRencontre?)> getDemandeById({required int id});

  Future<(Failure?, EntityDemandeRencontre?)> updateDemande({
    required int id,
    String? nomPrenoms,
    String? email,
    String? telephone,
    String? date,
    String? objet,
    String? statut,
  });

  Future<(Failure?, VoidType?)> deleteDemande({required int id});

  Future<(Failure?, EntityDemandeRencontre?)> accepterDemande(
      {required int id});

  Future<(Failure?, EntityDemandeRencontre?)> refuserDemande({required int id});

  Future<(Failure?, EntityDemandeRencontre?)> annulerDemande({required int id});
}
