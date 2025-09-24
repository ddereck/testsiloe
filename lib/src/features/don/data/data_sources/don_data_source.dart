import '../models/model_don.dart';

abstract class DonDataSource {
  Future<List<ModelDon>> getHistoriquePublic();

  Future<List<ModelDon>> getDonsAdmin({
    String? status,
    String? reseau,
    bool? anonyme,
    int? utilisateurId,
  });

  Future<List<ModelDon>> getMesDons();

  Future<ModelDon?> createDon({
    required String nomAffiche,
    required int montant,
    required String reseau,
    required bool anonyme,
  });

  Future<ModelDon?> getDonById({required int id});

  Future<void> deleteDon({required int id});

  Future<void> fedapayCallback({
    required String transactionId,
    required String status,
    required int montant,
    required int donId,
  });
}
