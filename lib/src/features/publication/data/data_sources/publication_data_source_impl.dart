import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'publication_data_source.dart';
import '../models/model_publication.dart';

class PublicationDataSourceImpl implements PublicationDataSource {
  final FirebaseAuth firebaseAuth;

  const PublicationDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelPublication?> createPublication({
    required int categorieId,
    required int typePublicationId,
    required String titre,
    required String description,
    required String datePublication,
    required String auteur,
    String? url,
    File? img,
    File? file,
    String? textArticle,
  }) async {
    try {
      final response = await ApiResources.post(ApiRoutes.publications,
          data: {
            ApiParams.categorieId: categorieId,
            ApiParams.typePublicationId: typePublicationId,
            ApiParams.titre: titre,
            ApiParams.description: description,
            ApiParams.datePublication: datePublication,
            ApiParams.auteur: auteur,
            ApiParams.url: url,
            ApiParams.img: img,
            ApiParams.file: file,
            ApiParams.texteArticle: textArticle,
            ApiParams.article: textArticle,
          },
          isFormData: true);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelPublication.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePublication({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.publicationById(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelPublication>> getAllPublications() async {
    try {
      final response = await ApiResources.get(ApiRoutes.publications);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelPublication.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelPublication?> getPublicationById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.publicationById(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelPublication.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelPublication?> updatePublication({
    required int id,
    required int categorieId,
    required int typePublicationId,
    required String titre,
    required String description,
    required String datePublication,
    required String auteur,
    String? url,
    File? img,
    File? file,
    String? textArticle,
  }) async {
    try {
      print('DEBUG API Update - URL: ${ApiRoutes.publicationById(id)}');
      print('DEBUG API Update - Method: POST with _method=PUT');
      print('DEBUG API Update - Data: {id: $id, titre: $titre, description: $description, auteur: $auteur, categorieId: $categorieId, typePublicationId: $typePublicationId, url: $url, img: ${img?.path ?? "null"}, textArticle: ${textArticle ?? "null"}}');
      
      final response =
          await ApiResources.post(ApiRoutes.publicationById(id), data: {
        '_method': 'PUT', // Important for Laravel to handle PUT with multipart/form-data
        ApiParams.id: id,
        ApiParams.categorieId: categorieId,
        ApiParams.typePublicationId: typePublicationId,
        ApiParams.titre: titre,
        ApiParams.description: description,
        ApiParams.datePublication: datePublication,
        ApiParams.auteur: auteur,
        ApiParams.url: url,
        ApiParams.img: img,
        ApiParams.file: file,
        ApiParams.texteArticle: textArticle,
        ApiParams.article: textArticle,
      }, isFormData: true);
      
      print('DEBUG API Update - Status: ${response.statusCode}');
      print('DEBUG API Update - Body: ${response.data}');
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelPublication.fromJson(response.data);
    } catch (e) {
      print('DEBUG API Update - Error: $e');
      throw Exception(e);
    }
  }
}
