import 'dart:io';

import 'package:get/get.dart';
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../domain/entities/entity_commentaire.dart' show EntityCommentaire;
import '../../domain/usecases/create_commentaire_usecase.dart'
    show CreateCommentaireUseCase, CreateCommentaireUseCaseParams;
import '../../domain/usecases/get_commentaires_usecase.dart'
    show GetCommentairesUseCase, GetCommentairesUseCaseParams;

// UseCases

class CommentaireController extends GetxController {
  final CreateCommentaireUseCase createCommentaireUseCase;
  final GetCommentairesUseCase getCommentairesUseCase;

  CommentaireController({
    required this.createCommentaireUseCase,
    required this.getCommentairesUseCase,
  });

  Future<EntityCommentaire?> createCommentaire({
    required int publicationId,
    required String nom,
    required String contenu,
    File? photo,
  }) async {
    try {
      final result = await createCommentaireUseCase.call(
        CreateCommentaireUseCaseParams(
          publicationId: publicationId,
          nom: nom,
          contenu: contenu,
          photo: photo,
        ),
      );

      if(result.$1 != null) {
        AppLogger.instance.logger.e("Error while creating commentaires: ${result.$2.toString()}", error: result.$2);
        return null;
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating commentaires: $e");
      return null;
    }
  }

  Future<List<EntityCommentaire>> getCommentaires({required int publicationId}) async {
    try {
      final result = await getCommentairesUseCase.call(GetCommentairesUseCaseParams(publicationId: publicationId));
      
      if(result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting commentaires: ${result.$2.toString()}", error: result.$2);
        return [];
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting commentaires: $e");
      return [];
    }
  }
}
