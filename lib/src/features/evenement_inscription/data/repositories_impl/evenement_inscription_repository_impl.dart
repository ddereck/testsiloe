import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_evenement_inscription.dart';
import '../../domain/repositories/evenement_inscription_repository.dart';
import '../data_sources/evenement_inscription_data_source.dart';

/// A class that implements [EvenementInscriptionRepository].
///
/// The class is named [EvenementInscriptionRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class EvenementInscriptionRepositoryImpl implements EvenementInscriptionRepository {

  final EvenementInscriptionDataSource dataSource;
  const EvenementInscriptionRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, VoidType?)> annulerInscription({required int evenementId, required int inscriptionId}) async {
    try {
      await dataSource.annulerInscription(evenementId: evenementId, inscriptionId: inscriptionId);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> confirmerInscription({required int evenementId, required int inscriptionId}) async {
    try {
      await dataSource.confirmerInscription(evenementId: evenementId, inscriptionId: inscriptionId);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityEvenementInscription>)> getInscriptions({required int evenementId}) async {
    try {
      final response = await dataSource.getInscriptions(evenementId: evenementId);
      return (null, response.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> inscrireEvenement(int evenementId, {String? commentaire}) async {
    try {
      await dataSource.inscrireEvenement(evenementId, commentaire: commentaire);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }



}
