import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_don.dart';
import '../../domain/repositories/don_repository.dart';
import '../data_sources/don_data_source.dart';

/// A class that implements [DonRepository].
///
/// The class is named [DonRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class DonRepositoryImpl implements DonRepository {

  final DonDataSource dataSource;
  const DonRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, EntityDon?)> createDon({required String nomAffiche, required int montant, required String reseau, required bool anonyme}) async {
    try {
      final result = await dataSource.createDon(nomAffiche: nomAffiche, montant: montant, reseau: reseau, anonyme: anonyme);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deleteDon({required int id}) async {
    try {
      await dataSource.deleteDon(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> fedapayCallback({required String transactionId, required String status, required int montant, required int donId}) async {
    try {
      await dataSource.fedapayCallback(transactionId: transactionId, status: status, montant: montant, donId: donId);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityDon?)> getDonById({required int id}) async {
    try {
      final result = await dataSource.getDonById(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityDon>)> getDonsAdmin({String? status, String? reseau, bool? anonyme, int? utilisateurId}) async {
    try {
      final result = await dataSource.getDonsAdmin(status: status, reseau: reseau, anonyme: anonyme, utilisateurId: utilisateurId);
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityDon>)> getHistoriquePublic() async {
    try {
      final result = await dataSource.getHistoriquePublic();
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityDon>)> getMesDons() async {
    try {
      final result = await dataSource.getMesDons();
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }



}
