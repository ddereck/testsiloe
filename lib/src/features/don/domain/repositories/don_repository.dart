import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [Don].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [DonRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_don.dart';

abstract class DonRepository {

Future<(Failure?, List<EntityDon>)> getHistoriquePublic();

  Future<(Failure?, List<EntityDon>)> getDonsAdmin({
    String? status,
    String? reseau,
    bool? anonyme,
    int? utilisateurId,
  });

  Future<(Failure?, List<EntityDon>)> getMesDons();

  Future<(Failure?, EntityDon?)> createDon({
    required String nomAffiche,
    required int montant,
    required String reseau,
    required bool anonyme,
  });

  Future<(Failure?, EntityDon?)> getDonById({required int id});

  Future<(Failure?, VoidType?)> deleteDon({required int id});

  Future<(Failure?, VoidType?)> fedapayCallback({
    required String transactionId,
    required String status,
    required int montant,
    required int donId,
  });

}
