import '../../../../core/errors/failure.dart';


import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_demande_rencontre.dart';
import '../../domain/repositories/demande_rencontre_repository.dart';
import '../data_sources/demande_rencontre_data_source.dart';

/// A class that implements [DemandeRencontreRepository].
///
/// The class is named [DemandeRencontreRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class DemandeRencontreRepositoryImpl implements DemandeRencontreRepository {

  final DemandeRencontreDataSource dataSource;
  const DemandeRencontreRepositoryImpl(this.dataSource);
  
  @override
  Future<(Failure?, EntityDemandeRencontre?)> accepterDemande({required int id}) async {
    try {
      final demandeRencontre = await dataSource.accepterDemande(id: id);
      return (null, demandeRencontre?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, EntityDemandeRencontre?)> annulerDemande({required int id}) async {
    try {
      final demandeRencontre = await dataSource.annulerDemande(id: id);
      return (null, demandeRencontre?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, EntityDemandeRencontre?)> createDemandeRencontre({required String nomPrenoms, required String email, required String telephone, 
  required String date, required String objet}) async {
    try {
      final demandeRencontre = await dataSource.createDemandeRencontre(nomPrenoms: nomPrenoms, email: email, telephone: telephone, date: date, objet: objet);
      return (null, demandeRencontre?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, VoidType?)> deleteDemande({required int id}) async {
    try {
      await dataSource.deleteDemande(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, EntityDemandeRencontre?)> getDemandeById({required int id}) async {
    try {
      final demandeRencontre = await dataSource.getDemandeById(id: id);
      return (null, demandeRencontre?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, List<EntityDemandeRencontre>)> getDemandes({String? statut, int? utilisateurId}) async {
    try {
      final demandeRencontres = await dataSource.getDemandes(statut: statut, utilisateurId: utilisateurId);
      return (null, demandeRencontres.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, List<EntityDemandeRencontre>)> getMesDemandes() async {
    try {
      final demandeRencontres = await dataSource.getMesDemandes();
      return (null, demandeRencontres.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, EntityDemandeRencontre?)> refuserDemande({required int id}) async {
    try {
      final demandeRencontre = await dataSource.refuserDemande(id: id);
      return (null, demandeRencontre?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, EntityDemandeRencontre?)> updateDemande({required int id, String? nomPrenoms, String? email, String? telephone, 
  String? date, String? objet, String? statut}) async {
    try {
      final demandeRencontre = await dataSource.updateDemande(id: id, nomPrenoms: nomPrenoms, email: email, telephone: telephone, 
        date: date, objet: objet, statut: statut);
      return (null, demandeRencontre?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

}
