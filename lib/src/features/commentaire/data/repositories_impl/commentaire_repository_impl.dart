import 'dart:io';

import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_commentaire.dart';
import '../../domain/repositories/commentaire_repository.dart';
import '../data_sources/commentaire_data_source.dart';

/// A class that implements [CommentaireRepository].
///
/// The class is named [CommentaireRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class CommentaireRepositoryImpl implements CommentaireRepository {
  final CommentaireDataSource dataSource;
  const CommentaireRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, EntityCommentaire?)> approuverCommentaire(
      {required int commentaireId}) async {
    try {
      final result =
          await dataSource.approuverCommentaire(commentaireId: commentaireId);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityCommentaire?)> createCommentaire(
      {required int publicationId,
      required String nom,
      required String contenu,
      File? photo}) async {
    try {
      final result = await dataSource.createCommentaire(
          publicationId: publicationId,
          nom: nom,
          contenu: contenu,
          photo: photo);
      return (
        null,
        result?.toEntity()
        // ignore: unnecessary_cast
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deleteCommentaire({required int id}) async {
    try {
      await dataSource.deleteCommentaire(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityCommentaire>)> getCommentaires(
      {required int publicationId}) async {
    try {
      final result =
          await dataSource.getCommentaires(publicationId: publicationId);
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityCommentaire>)> getCommentairesEnAttente() async {
    try {
      final result = await dataSource.getCommentairesEnAttente();
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityCommentaire>)> getReplies(
      {required int parentId}) async {
    try {
      final result = await dataSource.getReplies(parentId: parentId);
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityCommentaire?)> rejeterCommentaire(
      {required int commentaireId}) async {
    try {
      final result =
          await dataSource.rejeterCommentaire(commentaireId: commentaireId);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityCommentaire?)> replyToCommentaire(
      {required int parentId, required String contenu}) async {
    try {
      final result = await dataSource.replyToCommentaire(
          parentId: parentId, contenu: contenu);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityCommentaire?)> updateCommentaire(
      {required int id, required String contenu}) async {
    try {
      final result =
          await dataSource.updateCommentaire(id: id, contenu: contenu);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
}
