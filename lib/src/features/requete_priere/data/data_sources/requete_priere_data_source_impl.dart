import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'requete_priere_data_source.dart';
import '../models/model_requete_priere.dart';

class RequetePriereDataSourceImpl implements RequetePriereDataSource {
  final FirebaseAuth firebaseAuth;

  const RequetePriereDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelRequetePriere?> approuverRequetePriere({required int id}) async {
    try {
      final response =
          await ApiResources.post(ApiRoutes.approuverRequetePriere(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelRequetePriere.fromJson(response.data['requete']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelRequetePriere?> createRequetePriere(
      {required String nomPrenom,
      required String contenu,
      bool anonyme = true}) async {
    try {
      final data = {
        ApiParams.nomPrenom: nomPrenom,
        ApiParams.contenu: contenu,
        ApiParams.anonyme: anonyme,
      };

      final response =
          await ApiResources.post(ApiRoutes.requetesPriere, data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelRequetePriere.fromJson(response.data['requete']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteRequetePriere({required int id}) async {
    try {
      final response =
          await ApiResources.delete(ApiRoutes.requetePriereById(id));
      if (response.statusCode != 200 &&
          response.statusCode != 201 &&
          response.statusCode != 204) {
        throw Exception(response.data);
      }
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelRequetePriere?> getRequetePriereById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.requetePriereById(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelRequetePriere.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelRequetePriere>> getRequetesPriere(
      {String? statut, bool? anonyme}) async {
    try {
      final query = {
        if (statut != null) ApiParams.statut: statut,
        if (anonyme != null) ApiParams.anonyme: anonyme.toString(),
      };

      final response =
          await ApiResources.get(ApiRoutes.requetesPriere, query: query);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelRequetePriere.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelRequetePriere?> rejeterRequetePriere({required int id}) async {
    try {
      final response =
          await ApiResources.post(ApiRoutes.rejeterRequetePriere(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelRequetePriere.fromJson(response.data['requete']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelRequetePriere?> updateRequetePriere(
      {required int id,
      String? nomPrenom,
      String? contenu,
      bool? anonyme,
      String? statut}) async {
    try {
      final data = {
        if (nomPrenom != null) ApiParams.nomPrenom: nomPrenom,
        if (contenu != null) ApiParams.contenu: contenu,
        if (anonyme != null) ApiParams.anonyme: anonyme,
        if (statut != null) ApiParams.statut: statut,
      };

      final response =
          await ApiResources.put(ApiRoutes.requetePriereById(id), data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelRequetePriere.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
