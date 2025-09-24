import 'dart:io';

import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [Commentaire].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [CommentaireRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_commentaire.dart';

abstract class CommentaireRepository {

  // Lister les commentaires d’une publication
  Future<(Failure?, List<EntityCommentaire>)> getCommentaires({required int publicationId});

  // Poster un commentaire sur une publication
  Future<(Failure?, EntityCommentaire?)> createCommentaire({
    required int publicationId,
    required String nom,
    required String contenu,
    File? photo,
  });

  // Répondre à un commentaire
  Future<(Failure?, EntityCommentaire?)> replyToCommentaire({
    required int parentId,
    required String contenu,
  });

  // Obtenir les réponses
  Future<(Failure?, List<EntityCommentaire>)> getReplies({required int parentId});

  // Mettre à jour un commentaire
  Future<(Failure?, EntityCommentaire?)> updateCommentaire({required int id, required String contenu});

  // Supprimer un commentaire
  Future<(Failure?, VoidType?)> deleteCommentaire({required int id});

  // Admin (approbation & modération)
  Future<(Failure?, List<EntityCommentaire>)> getCommentairesEnAttente();

  Future<(Failure?, EntityCommentaire?)> approuverCommentaire({required int commentaireId});

  Future<(Failure?, EntityCommentaire?)> rejeterCommentaire({required int commentaireId});

}
