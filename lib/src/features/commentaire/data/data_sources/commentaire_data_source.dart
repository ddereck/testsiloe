import 'dart:io';

import '../models/model_commentaire.dart';

abstract class CommentaireDataSource {
  // Lister les commentaires d’une publication
  Future<List<ModelCommentaire>> getCommentaires({required int publicationId});

  // Poster un commentaire sur une publication
  Future<ModelCommentaire?> createCommentaire({
    required int publicationId,
    required String nom,
    required String contenu,
    File? photo,
  });

  // Répondre à un commentaire
  Future<ModelCommentaire?> replyToCommentaire({
    required int parentId,
    required String contenu,
  });

  // Obtenir les réponses
  Future<List<ModelCommentaire>> getReplies({required int parentId});

  // Mettre à jour un commentaire
  Future<ModelCommentaire?> updateCommentaire({required int id, required String contenu});

  // Supprimer un commentaire
  Future<void> deleteCommentaire({required int id});

  // Admin (approbation & modération)
  Future<List<ModelCommentaire>> getCommentairesEnAttente();

  Future<ModelCommentaire?> approuverCommentaire({required int commentaireId});

  Future<ModelCommentaire?> rejeterCommentaire({required int commentaireId});
}
