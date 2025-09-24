import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'evenement_data_source.dart';
import '../models/model_evenement.dart';

class EvenementDataSourceImpl implements EvenementDataSource {
  final FirebaseAuth firebaseAuth;

  const EvenementDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelEvenement?> createEvenement({
    required int categorieId,
    required int typePublicationId,
    required String theme,
    String? texteArticle,
    File? imageDeCouverture,
    required String dateEvenement,
    String? dateFin,
    String? lieu,
    int? placesLimitees,
  }) async {
    try {
      final response = await ApiResources.post(ApiRoutes.evenements,
          data: {
            ApiParams.categorieId: categorieId,
            ApiParams.typePublicationId: typePublicationId,
            ApiParams.theme: theme,
            if (texteArticle != null) ApiParams.texteArticle: texteArticle,
            ApiParams.dateEvenement: dateEvenement,
            if (dateFin != null) ApiParams.dateFin: dateFin,
            if (lieu != null) ApiParams.lieu: lieu,
            if (placesLimitees != null) ApiParams.placesLimitees: placesLimitees,
            if (imageDeCouverture != null) ApiParams.imageDeCouverture: imageDeCouverture,
          },
          isFormData: true);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelEvenement.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteEvenement({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.evenementById(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelEvenement>> getAllEvenements({
    String? statut,
    int? categorieId,
    String? dateDebut,
    String? dateFin,
  }) async {
    try {
      final response = await ApiResources.get(ApiRoutes.evenements, query: {
        if (statut != null) ApiParams.statut: statut,
        if (categorieId != null) ApiParams.categorieId: categorieId.toString(),
        if (dateDebut != null) ApiParams.dateDebut: dateDebut,
        if (dateFin != null) ApiParams.dateFin: dateFin,
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelEvenement.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des événements : $e');
    }
  }

  @override
  Future<ModelEvenement?> getEvenementById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.evenementById(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelEvenement.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l’événement : $e');
    }
  }

  @override
  Future<ModelEvenement?> updateEvenement({
    required int id,
    int? categorieId,
    int? typePublicationId,
    String? theme,
    String? texteArticle,
    File? imageDeCouverture,
    String? dateEvenement,
    String? dateFin,
    String? lieu,
    int? placesLimitees,
  }) async {
    try {
      final response = await ApiResources.put(ApiRoutes.evenementById(id),
          data: {
            ApiParams.categorieId: categorieId,
            ApiParams.typePublicationId: typePublicationId,
            ApiParams.theme: theme,
            if (texteArticle != null) ApiParams.texteArticle: texteArticle,
            ApiParams.dateEvenement: dateEvenement,
            if (dateFin != null) ApiParams.dateFin: dateFin,
            if (lieu != null) ApiParams.lieu: lieu,
            if (placesLimitees != null) ApiParams.placesLimitees: placesLimitees,
            if (imageDeCouverture != null) ApiParams.imageDeCouverture: imageDeCouverture,
          },
          isFormData: true);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelEvenement.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
