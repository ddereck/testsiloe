import 'dart:io';

import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;

/// An abstract class that represents a repository for the feature [Publication].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [PublicationRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_publication.dart';

abstract class PublicationRepository {
  Future<(Failure?, List<EntityPublication>)> getAllPublications();

  Future<(Failure?, EntityPublication?)> getPublicationById({required int id});

  Future<(Failure?, EntityPublication?)> createPublication({
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
  });

  Future<(Failure?, EntityPublication?)> updatePublication({
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
  });

  Future<(Failure?, VoidType?)> deletePublication({required int id});
}
