import '../models/model_evenement_inscription.dart';

abstract class EvenementInscriptionDataSource {

  // S’inscrire à un événement
  Future<void> inscrireEvenement(int evenementId, {String? commentaire});

  // Voir les inscriptions à un événement (admin / creator only)
  Future<List<ModelEvenementInscription>> getInscriptions({required int evenementId});

  // Confirmer une inscription
  Future<void> confirmerInscription({required int evenementId, required int inscriptionId});

  // Annuler une inscription
  Future<void> annulerInscription({required int evenementId, required int inscriptionId});

}
