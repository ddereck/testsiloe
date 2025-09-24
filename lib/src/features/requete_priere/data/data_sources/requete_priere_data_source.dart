import '../models/model_requete_priere.dart';

abstract class RequetePriereDataSource {
  Future<ModelRequetePriere?> createRequetePriere({
    required String nomPrenom,
    required String contenu,
    bool anonyme = true,
  });

  Future<ModelRequetePriere?> getRequetePriereById({required int id});

  Future<List<ModelRequetePriere>> getRequetesPriere({
    String? statut,
    bool? anonyme,
  });

  Future<ModelRequetePriere?> updateRequetePriere({
    required int id,
    String? nomPrenom,
    String? contenu,
    bool? anonyme,
    String? statut,
  });

  Future<void> deleteRequetePriere({required int id});

  Future<ModelRequetePriere?> approuverRequetePriere({required int id});

  Future<ModelRequetePriere?> rejeterRequetePriere({required int id});
}
