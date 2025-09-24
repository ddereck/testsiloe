import 'package:get/get.dart';

// UseCases
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../domain/entities/entity_requete_priere.dart'
    show EntityRequetePriere;
import '../../domain/usecases/approuver_requete_priere_usecase.dart'
    show ApprouverRequetePriereUseCase, ApprouverRequetePriereUseCaseParams;
import '../../domain/usecases/create_requete_priere_usecase.dart'
    show CreateRequetePriereUseCase, CreateRequetePriereUseCaseParams;
import '../../domain/usecases/delete_requete_priere_usecase.dart'
    show DeleteRequetePriereUseCase, DeleteRequetePriereUseCaseParams;
import '../../domain/usecases/get_requete_priere_by_id_usecase.dart'
    show GetRequetePriereByIdUseCase, GetRequetePriereByIdUseCaseParams;
import '../../domain/usecases/get_requetes_priere_usecase.dart'
    show GetRequetesPriereUseCase, GetRequetesPriereUseCaseParams;
import '../../domain/usecases/rejeter_requete_priere_usecase.dart'
    show RejeterRequetePriereUseCase, RejeterRequetePriereUseCaseParams;
import '../../domain/usecases/update_requete_priere_usecase.dart'
    show UpdateRequetePriereUseCase, UpdateRequetePriereUseCaseParams;

class RequetePriereController extends GetxController {
  final ApprouverRequetePriereUseCase approuverRequetePriereUseCase;
  final RejeterRequetePriereUseCase rejeterRequetePriereUseCase;
  final DeleteRequetePriereUseCase deleteRequetePriereUseCase;
  final GetRequetePriereByIdUseCase getRequetePriereByIdUseCase;
  final GetRequetesPriereUseCase getRequetesPriereUseCase;
  final CreateRequetePriereUseCase createRequetePriereUseCase;
  final UpdateRequetePriereUseCase updateRequetePriereUseCase;

  RequetePriereController(
      {required this.approuverRequetePriereUseCase,
      required this.rejeterRequetePriereUseCase,
      required this.deleteRequetePriereUseCase,
      required this.getRequetePriereByIdUseCase,
      required this.getRequetesPriereUseCase,
      required this.createRequetePriereUseCase,
      required this.updateRequetePriereUseCase});

  Future<EntityRequetePriere?> getRequetePriereById({required int id}) async {
    try {
      final response = await getRequetePriereByIdUseCase
          .call(GetRequetePriereByIdUseCaseParams(id: id));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting demande rencontre by id: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }
      return response.$2;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting demande rencontre by id: $e");
      return null;
    }
  }

  Future<List<EntityRequetePriere>> getRequetesPriere(
      {String? statut, bool? anonyme}) async {
    try {
      final response = await getRequetesPriereUseCase.call(
          GetRequetesPriereUseCaseParams(statut: statut, anonyme: anonyme));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting demande rencontre by id: ${response.$2.toString()}",
            error: response.$2);
        return [];
      }
      return response.$2;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting demande rencontre by id: $e");
      return [];
    }
  }

  Future<EntityRequetePriere?> createRequetePriere({
    required String nomPrenom,
    required String contenu,
    bool anonyme = true,
  }) async {
    try {
      final response = await createRequetePriereUseCase.call(
          CreateRequetePriereUseCaseParams(
              nomPrenom: nomPrenom, contenu: contenu, anonyme: anonyme));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting demande rencontre by id: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }
      return response.$2;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting demande rencontre by id: $e");
      return null;
    }
  }

  Future<EntityRequetePriere?> updateRequetePriere({
    required int id,
    String? nomPrenom,
    String? contenu,
    bool? anonyme,
    String? statut,
  }) async {
    try {
      final response = await updateRequetePriereUseCase
          .call(UpdateRequetePriereUseCaseParams(
        id: id,
        nomPrenom: nomPrenom,
        contenu: contenu,
        anonyme: anonyme,
        statut: statut,
      ));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting demande rencontre by id: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }
      return response.$2;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting demande rencontre by id: $e");
      return null;
    }
  }

  Future<EntityRequetePriere?> approuverRequetePriere({required int id}) async {
    try {
      final response = await approuverRequetePriereUseCase
          .call(ApprouverRequetePriereUseCaseParams(id: id));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting demande rencontre by id: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }
      return response.$2;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting demande rencontre by id: $e");
      return null;
    }
  }

  Future<EntityRequetePriere?> repondreRequete({
    required int id,
    required String reponse,
  }) async {
    try {
      final response = await updateRequetePriereUseCase.call(
        UpdateRequetePriereUseCaseParams(
          id: id,
          contenu: reponse, // on utilise le champ contenu pour la réponse
        ),
      );

      if (response.$1 != null) {
        AppLogger.instance.logger.e(
          "Error while replying to requete prière: ${response.$2.toString()}",
          error: response.$2,
        );
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while replying to requete prière: $e");
      return null;
    }
  }

  Future<EntityRequetePriere?> rejeterRequetePriere({required int id}) async {
    try {
      final response = await rejeterRequetePriereUseCase
          .call(RejeterRequetePriereUseCaseParams(id: id));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting demande rencontre by id: ${response.$2.toString()}",
            error: response.$2);
        return null;
      }
      return response.$2;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting demande rencontre by id: $e");
      return null;
    }
  }

  Future<void> deleteRequetePriere({required int id}) async {
    try {
      final response = await deleteRequetePriereUseCase
          .call(DeleteRequetePriereUseCaseParams(id: id));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting demande rencontre by id: ${response.$2.toString()}",
            error: response.$2);
        return;
      }
      return;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting demande rencontre by id: $e");
      return;
    }
  }
}
