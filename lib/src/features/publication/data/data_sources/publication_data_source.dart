import 'dart:io';

import '../models/model_publication.dart';

abstract class PublicationDataSource {
  Future<List<ModelPublication>> getAllPublications();

  Future<ModelPublication?> getPublicationById({required int id});

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
  });

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
  });

  Future<void> deletePublication({required int id});
}
