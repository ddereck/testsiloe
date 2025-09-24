import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'evenement_inscription_data_source.dart';
import '../models/model_evenement_inscription.dart';

class EvenementInscriptionDataSourceImpl
    implements EvenementInscriptionDataSource {
  final FirebaseAuth firebaseAuth;

  const EvenementInscriptionDataSourceImpl(this.firebaseAuth);

  @override
  Future<void> annulerInscription(
      {required int evenementId, required int inscriptionId}) async {
    try {
      final response = await ApiResources.post(
        ApiRoutes.annulerInscription(evenementId, inscriptionId),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> confirmerInscription(
      {required int evenementId, required int inscriptionId}) async {
    try {
      final response = await ApiResources.post(
        ApiRoutes.confirmerInscription(evenementId, inscriptionId),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelEvenementInscription>> getInscriptions(
      {required int evenementId}) async {
    try {
      final response =
          await ApiResources.get(ApiRoutes.listeInscriptions(evenementId));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelEvenementInscription.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> inscrireEvenement(int evenementId, {String? commentaire}) async {
    try {
      final response = await ApiResources.post(
          ApiRoutes.inscrireEvenement(evenementId),
          data: {
            if (commentaire != null) ApiParams.commentaire: commentaire,
          });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return;
    } catch (e) {
      throw Exception(e);
    }
  }
}
