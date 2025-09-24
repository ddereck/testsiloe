import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'don_data_source.dart';
import '../models/model_don.dart';

class DonDataSourceImpl implements DonDataSource {
  final FirebaseAuth firebaseAuth;

  const DonDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelDon?> createDon({
    required String nomAffiche,
    required int montant,
    required String reseau,
    required bool anonyme,
  }) async {
    try {
      final data = {
        ApiParams.nomAffiche: nomAffiche,
        ApiParams.montant: montant,
        ApiParams.reseau: reseau,
        ApiParams.anonyme: anonyme,
      };

      final response = await ApiResources.post(ApiRoutes.dons, data: data);

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception(response.data);
      }

      return ModelDon.fromJson(response.data['don']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteDon({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.donById(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> fedapayCallback({
    required String transactionId,
    required String status,
    required int montant,
    required int donId,
  }) async {
    try {
      final data = {
        ApiParams.transactionId: transactionId,
        ApiParams.status: status,
        ApiParams.montant: montant,
        ApiParams.donId: donId,
      };

      final response =
          await ApiResources.post(ApiRoutes.fedapayCallback, data: data);

      if (response.statusCode != 200) throw Exception(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelDon?> getDonById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.donById(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelDon.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelDon>> getDonsAdmin({
    String? status,
    String? reseau,
    bool? anonyme,
    int? utilisateurId,
  }) async {
    try {
      final response = await ApiResources.get(ApiRoutes.dons, query: {
        if (status != null) ApiParams.status: status,
        if (reseau != null) ApiParams.reseau: reseau,
        if (anonyme != null) ApiParams.anonyme: anonyme,
        if (utilisateurId != null) ApiParams.utilisateurId: utilisateurId,
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelDon.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelDon>> getHistoriquePublic() async {
    try {
      final response = await ApiResources.get(ApiRoutes.donsHistorique);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data as List).map((e) => ModelDon.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelDon>> getMesDons() async {
    try {
      final response = await ApiResources.get(ApiRoutes.mesDons);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelDon.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
