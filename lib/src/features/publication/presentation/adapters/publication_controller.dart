import 'dart:io';

import 'package:get/get.dart';

// UseCases

import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/params.dart' show NoParams, VoidType;
import '../../domain/entities/entity_publication.dart' show EntityPublication;
import '../../domain/usecases/create_publication_usecase.dart' show CreatePublicationUseCase, CreatePublicationUseCaseParams;
import '../../domain/usecases/delete_publication_usecase.dart' show DeletePublicationUseCase, DeletePublicationUseCaseParams;
import '../../domain/usecases/get_all_publication_usecase.dart' show GetAllPublicationUseCase;
import '../../domain/usecases/get_publication_by_id_usecase.dart' show GetPublicationByIdUseCase, GetPublicationByIdUseCaseParams;
import '../../domain/usecases/update_publication_usecase.dart' show UpdatePublicationUseCase, UpdatePublicationUseCaseParams;

class PublicationController extends GetxController {
  final GetAllPublicationUseCase getAllPublicationUseCase;
  final GetPublicationByIdUseCase getPublicationByIdUseCase;
  final DeletePublicationUseCase deletePublicationUseCase;
  final CreatePublicationUseCase createPublicationUseCase;
  final UpdatePublicationUseCase updatePublicationUseCase;

  PublicationController({
    required this.getAllPublicationUseCase,
    required this.getPublicationByIdUseCase,
    required this.deletePublicationUseCase,
    required this.createPublicationUseCase,
    required this.updatePublicationUseCase,
  });

  Future<List<EntityPublication>> getAllPublications() async {
    try {
      final result = await getAllPublicationUseCase.call(NoParams());
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting publications: ${result.$2.toString()}", error: result.$2);
        return [];
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting publications: $e");
      return [];
    }
  }

  Future<EntityPublication?> getPublicationById({required int id}) async {
    try {
      final result = await getPublicationByIdUseCase.call(GetPublicationByIdUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting publication by id: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting publication by id: $e");
      return null;
    }
  }

  Future<VoidType?> deletePublication({required int id}) async {
    try {
      final result = await deletePublicationUseCase.call(DeletePublicationUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while deleting publication: ${result.$2.toString()}", error: result.$2);
        return null;
      }

      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting publication: $e");
      return null;
    }
  }

  Future<EntityPublication?> createPublication({
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
      final result = await createPublicationUseCase.call(CreatePublicationUseCaseParams(
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
      ));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while creating publication: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating publication: $e");
      return null;
    }
  }

  Future<EntityPublication?> updatePublication({
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
      final result = await updatePublicationUseCase.call(UpdatePublicationUseCaseParams(
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
        textArticle: textArticle,
      ));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while updating publication: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while updating publication: $e");
      return null;
    }
  }
}
