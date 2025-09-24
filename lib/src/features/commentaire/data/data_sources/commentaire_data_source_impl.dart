import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import 'commentaire_data_source.dart';
import '../models/model_commentaire.dart';

class CommentaireDataSourceImpl implements CommentaireDataSource {
  final FirebaseAuth firebaseAuth;

  const CommentaireDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelCommentaire?> createCommentaire({
    required int publicationId,
    required String nom,
    required String contenu,
    File? photo,
  }) async {
    try {
      final response = await ApiResources.post(ApiRoutes.commentairesByPublication(publicationId),
          data: {
            ApiParams.nom: nom,
            ApiParams.contenu: contenu,
            ApiParams.photo: photo,
          },
          isFormData: true);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      AppLogger.instance.logger.i(response.data);
      return ModelCommentaire.fromJson(response.data['commentaire']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCommentaire({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.commentaireById(id));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelCommentaire>> getCommentaires(
      {required int publicationId}) async {
    try {
      final response = await ApiResources.get(
        ApiRoutes.commentairesByPublication(publicationId),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelCommentaire.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelCommentaire>> getReplies({required int parentId}) async {
    try {
      final response =
          await ApiResources.get(ApiRoutes.commentaireReplies(parentId));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelCommentaire.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelCommentaire?> replyToCommentaire(
      {required int parentId, required String contenu}) async {
    try {
      final response = await ApiResources.post(
        ApiRoutes.commentaireReplies(parentId),
        data: {ApiParams.contenu: contenu},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelCommentaire.fromJson(response.data['reply']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelCommentaire?> updateCommentaire(
      {required int id, required String contenu}) async {
    try {
      final response = await ApiResources.put(ApiRoutes.commentaireById(id),
          data: {
            ApiParams.contenu: contenu,
          },
          isFormData: true);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelCommentaire.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelCommentaire?> approuverCommentaire(
      {required int commentaireId}) async {
    try {
      final response = await ApiResources.post(
          ApiRoutes.approuverCommentaire(commentaireId));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelCommentaire.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelCommentaire>> getCommentairesEnAttente() async {
    try {
      final response = await ApiResources.get(ApiRoutes.commentairesEnAttente);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelCommentaire.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelCommentaire?> rejeterCommentaire(
      {required int commentaireId}) async {
    try {
      final response =
          await ApiResources.post(ApiRoutes.rejeterCommentaire(commentaireId));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelCommentaire.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
