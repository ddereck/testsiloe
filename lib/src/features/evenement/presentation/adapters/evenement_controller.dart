import 'dart:io';

import 'package:get/get.dart';
import 'package:siloe/src/core/logs/custom_logger.dart';

// UseCases
import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_evenement.dart' show EntityEvenement;
import '../../domain/usecases/create_evenement_usecase.dart'
    show CreateEvenementUseCase, CreateEvenementUseCaseParams;
import '../../domain/usecases/delete_evenement_usecase.dart'
    show DeleteEvenementUseCase, DeleteEvenementUseCaseParams;
import '../../domain/usecases/get_all_evenements_usecase.dart'
    show GetAllEvenementsUseCase, GetAllEvenementsUseCaseParams;
import '../../domain/usecases/get_evenement_by_id_usecase.dart'
    show GetEvenementByIdUseCase, GetEvenementByIdUseCaseParams;
import '../../domain/usecases/update_evenement_usecase.dart'
    show UpdateEvenementUseCase, UpdateEvenementUseCaseParams;

class EvenementController extends GetxController {
  final GetAllEvenementsUseCase getAllEvenementsUseCase;
  final GetEvenementByIdUseCase getEvenementByIdUseCase;
  final CreateEvenementUseCase createEvenementUseCase;
  final UpdateEvenementUseCase updateEvenementUseCase;
  final DeleteEvenementUseCase deleteEvenementUseCase;

  EvenementController({
    required this.getAllEvenementsUseCase,
    required this.getEvenementByIdUseCase,
    required this.createEvenementUseCase,
    required this.updateEvenementUseCase,
    required this.deleteEvenementUseCase,
  });

  Future<List<EntityEvenement>> getAllEvenements({
    String? statut,
    int? categorieId,
    String? dateDebut,
    String? dateFin,
  }) async {
    try {
      final response =
          await getAllEvenementsUseCase.call(GetAllEvenementsUseCaseParams(
        statut: statut,
        categorieId: categorieId,
        dateDebut: dateDebut,
        dateFin: dateFin,
      ));

      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting evenements: ${response.$2.toString()}",
            error: response.$2);
        return [];
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting evenements: $e");
      return [];
    }
  }

  Future<EntityEvenement?> getEvenementById({required int id}) async {
    try {
      final response = await getEvenementByIdUseCase
          .call(GetEvenementByIdUseCaseParams(id: id));

      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting evenement: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting evenement: $e");
      return null;
    }
  }

  Future<EntityEvenement?> createEvenement({
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
      final response =
          await createEvenementUseCase.call(CreateEvenementUseCaseParams(
        categorieId: categorieId,
        typePublicationId: typePublicationId,
        theme: theme,
        texteArticle: texteArticle,
        imageDeCouverture: imageDeCouverture,
        dateEvenement: dateEvenement,
        dateFin: dateFin,
        lieu: lieu,
        placesLimitees: placesLimitees,
      ));

      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while creating evenement: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating evenement: $e");
      return null;
    }
  }

  Future<EntityEvenement?> updateEvenement({
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
      final response =
          await updateEvenementUseCase.call(UpdateEvenementUseCaseParams(
        id: id,
        categorieId: categorieId,
        typePublicationId: typePublicationId,
        theme: theme,
        texteArticle: texteArticle,
        imageDeCouverture: imageDeCouverture,
        dateEvenement: dateEvenement,
        dateFin: dateFin,
        lieu: lieu,
        placesLimitees: placesLimitees,
      ));

      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while updating evenement: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while updating evenement: $e");
      return null;
    }
  }

  Future<VoidType?> deleteEvenement({required int id}) async {
    try {
      final response =
          await deleteEvenementUseCase.call(DeleteEvenementUseCaseParams(id: id));

      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while deleting evenement: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting evenement: $e");
      return null;
    }
  }
}
