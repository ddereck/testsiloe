import 'dart:io';

import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';

import '../../domain/entities/entity_publication.dart';
import '../../domain/repositories/publication_repository.dart';
import '../data_sources/publication_data_source.dart';

/// A class that implements [PublicationRepository].
///
/// The class is named [PublicationRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationDataSource dataSource;
  const PublicationRepositoryImpl(this.dataSource);

  @override
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
  }) async {
    try {
      final result = await dataSource.createPublication(
        categorieId: categorieId,
        typePublicationId: typePublicationId,
        titre: titre,
        description: description,
        datePublication: datePublication,
        auteur: auteur,
        url: url,
        img: img,
        file: file,
        textArticle: textArticle,
      );
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deletePublication({required int id}) async {
    try {
      await dataSource.deletePublication(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityPublication>)> getAllPublications() async {
    try {
      final result = await dataSource.getAllPublications();
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityPublication?)> getPublicationById(
      {required int id}) async {
    try {
      final result = await dataSource.getPublicationById(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
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
  }) async {
    try {
      final result = await dataSource.updatePublication(
          id: id,
          categorieId: categorieId,
          typePublicationId: typePublicationId,
          titre: titre,
          description: description,
          datePublication: datePublication,
          auteur: auteur,
          url: url,
          img: img,
          file: file,
          textArticle: textArticle);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
}
