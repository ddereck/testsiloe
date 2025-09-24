import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [EvenementInscription].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [EvenementInscriptionRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_evenement_inscription.dart';

abstract class EvenementInscriptionRepository {


  // S’inscrire à un événement
  Future<(Failure?, VoidType?)> inscrireEvenement(int evenementId, {String? commentaire});

  // Voir les inscriptions à un événement (admin / creator only)
  Future<(Failure?, List<EntityEvenementInscription>)> getInscriptions({required int evenementId});

  // Confirmer une inscription
  Future<(Failure?, VoidType?)> confirmerInscription({required int evenementId, required int inscriptionId});

  // Annuler une inscription
  Future<(Failure?, VoidType?)> annulerInscription({required int evenementId, required int inscriptionId});

}
