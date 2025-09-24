import '../../../../core/errors/failure.dart';


import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_requete_priere.dart';
import '../../domain/repositories/requete_priere_repository.dart';
import '../data_sources/requete_priere_data_source.dart';

/// A class that implements [RequetePriereRepository].
///
/// The class is named [RequetePriereRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class RequetePriereRepositoryImpl implements RequetePriereRepository {

  final RequetePriereDataSource dataSource;
  const RequetePriereRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, EntityRequetePriere?)> approuverRequetePriere({required int id}) async {
    try {
      final requetePriere = await dataSource.approuverRequetePriere(id: id);
      return (null, requetePriere?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityRequetePriere?)> createRequetePriere({required String nomPrenom, required String contenu, bool anonyme = true}) async {
    try {
      final requetePriere = await dataSource.createRequetePriere(nomPrenom: nomPrenom, contenu: contenu, anonyme: anonyme);
      return (null, requetePriere?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deleteRequetePriere({required int id}) async {
    try {
      await dataSource.deleteRequetePriere(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityRequetePriere?)> getRequetePriereById({required int id}) async {
    try {
      final requetePriere = await dataSource.getRequetePriereById(id: id);
      return (null, requetePriere?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityRequetePriere>)> getRequetesPriere({String? statut, bool? anonyme}) async {
    try {
      final requetePrieres = await dataSource.getRequetesPriere(statut: statut, anonyme: anonyme);
      return (null, requetePrieres.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityRequetePriere?)> rejeterRequetePriere({required int id}) async {
    try {
      final requetePriere = await dataSource.rejeterRequetePriere(id: id);
      return (null, requetePriere?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityRequetePriere?)> updateRequetePriere({required int id, String? nomPrenom, String? contenu, bool? anonyme, String? statut}) async {
    try {
      final requetePriere = await dataSource.updateRequetePriere(id: id, nomPrenom: nomPrenom, contenu: contenu, anonyme: anonyme, statut: statut);
      return (null, requetePriere?.toEntity());
    } catch (e) {
      rethrow;
    }
  }



}
