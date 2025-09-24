import '../models/model_demande_rencontre.dart';

abstract class DemandeRencontreDataSource {
  Future<List<ModelDemandeRencontre>> getDemandes(
      {String? statut, int? utilisateurId});

  Future<List<ModelDemandeRencontre>> getMesDemandes();

  Future<ModelDemandeRencontre?> createDemandeRencontre({
    required String nomPrenoms,
    required String email,
    required String telephone,
    required String date,
    required String objet,
  });

  Future<ModelDemandeRencontre?> getDemandeById({required int id});

  Future<ModelDemandeRencontre?> updateDemande({
    required int id,
    String? nomPrenoms,
    String? email,
    String? telephone,
    String? date,
    String? objet,
    String? statut,
  });

  Future<void> deleteDemande({required int id});

  Future<ModelDemandeRencontre?> accepterDemande({required int id});
  
  Future<ModelDemandeRencontre?> refuserDemande({required int id});

  Future<ModelDemandeRencontre?> annulerDemande({required int id});
}
