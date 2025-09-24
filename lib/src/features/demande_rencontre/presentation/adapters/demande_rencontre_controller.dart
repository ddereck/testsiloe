import 'package:get/get.dart';
// UseCases
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/params.dart' show NoParams, VoidType;
import '../../domain/entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../../domain/usecases/accepter_demande_rencontre_usecase.dart' show AccepterDemandeRencontreUseCase, AccepterDemandeRencontreUseCaseParams;
import '../../domain/usecases/annuler_demande_rencontre_usecase.dart' show AnnulerDemandeRencontreUseCase, AnnulerDemandeRencontreUseCaseParams;
import '../../domain/usecases/create_demande_rencontre_usecase.dart' show CreateDemandeRencontreUseCase, CreateDemandeRencontreUseCaseParams;
import '../../domain/usecases/delete_demande_rencontre_usecase.dart' show DeleteDemandeRencontreUseCase, DeleteDemandeRencontreUseCaseParams;
import '../../domain/usecases/get_demande_rencontre_by_id_usecase.dart' show GetDemandeRencontreByIdUseCase, GetDemandeRencontreByIdUseCaseParams;
import '../../domain/usecases/get_demandes_rencontre_usecase.dart' show GetDemandesRencontreUseCase, GetDemandesRencontreUseCaseParams;
import '../../domain/usecases/get_mes_demandes_rencontre_usecase.dart' show GetMesDemandesRencontreUseCase;
import '../../domain/usecases/refuser_demande_rencontre_usecase.dart' show RefuserDemandeRencontreUseCase, RefuserDemandeRencontreUseCaseParams;
import '../../domain/usecases/update_demande_rencontre_usecase.dart' show UpdateDemandeRencontreUseCase, UpdateDemandeRencontreUseCaseParams;

class DemandeRencontreController extends GetxController {

  final GetDemandesRencontreUseCase getDemandesRencontreUseCase;
  final GetMesDemandesRencontreUseCase getMesDemandesRencontreUseCase;
  final GetDemandeRencontreByIdUseCase getDemandeRencontreByIdUseCase;
  final AccepterDemandeRencontreUseCase accepterDemandeRencontreUseCase;
  final RefuserDemandeRencontreUseCase refuserDemandeRencontreUseCase;
  final AnnulerDemandeRencontreUseCase annulerDemandeRencontreUseCase;
  final CreateDemandeRencontreUseCase createDemandeRencontreUseCase;
  final UpdateDemandeRencontreUseCase updateDemandeRencontreUseCase;
  final DeleteDemandeRencontreUseCase deleteDemandeRencontreUseCase;

  DemandeRencontreController({
    required this.getDemandesRencontreUseCase,
    required this.getMesDemandesRencontreUseCase,
    required this.getDemandeRencontreByIdUseCase,
    required this.accepterDemandeRencontreUseCase,
    required this.refuserDemandeRencontreUseCase,
    required this.annulerDemandeRencontreUseCase,
    required this.createDemandeRencontreUseCase,
    required this.updateDemandeRencontreUseCase,
    required this.deleteDemandeRencontreUseCase,
  });

  Future<List<EntityDemandeRencontre>> getMesDemandesRencontre() async {
    try {
      final result = await getMesDemandesRencontreUseCase.call(NoParams());
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting mes demandes rencontres: ${result.$2.toString()}", error: result.$2);
        return [];
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting demandes rencontres: $e");
      return [];
    }
  }

  Future<List<EntityDemandeRencontre>> getDemandesRencontre({String? statut, int? utilisateurId}) async {
    try {
      final result = await getDemandesRencontreUseCase.call(GetDemandesRencontreUseCaseParams(statut: statut, utilisateurId: utilisateurId));
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting demandes rencontres: ${result.$2.toString()}", error: result.$2);
        return [];
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting demandes rencontres: $e");
      return [];
    }
  }

  Future<EntityDemandeRencontre?> getDemandeRencontreById(int id) async {
    try {
      final result = await getDemandeRencontreByIdUseCase.call(GetDemandeRencontreByIdUseCaseParams(id: id));
      
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting demande rencontre by id: ${result.$2.toString()}", error: result.$2);
        return null;
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting demande rencontre by id: $e");
      return null;
    }
  }

  Future<EntityDemandeRencontre?> accepterDemandeRencontre({required int id}) async {
    try {
      final result = await accepterDemandeRencontreUseCase.call(AccepterDemandeRencontreUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while accepting demande rencontre: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while accepting demande rencontre: $e");
      return null;
    }
  }

  Future<EntityDemandeRencontre?> refuserDemandeRencontre({required int id}) async {
    try {
      final result = await refuserDemandeRencontreUseCase.call(RefuserDemandeRencontreUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while refusing demande rencontre: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while refusing demande rencontre: $e");
      return null;
    }
  }

  Future<EntityDemandeRencontre?> annulerDemandeRencontre({required int id}) async {
    try {
      final result = await annulerDemandeRencontreUseCase.call(AnnulerDemandeRencontreUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while annuler demande rencontre: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while annuler demande rencontre: $e");
      return null;
    }
  }

  Future<EntityDemandeRencontre?> createDemandeRencontre({required String nomPrenoms, required String email, required String telephone, 
    required String date, required String objet}) async {
    try {
      final result = await createDemandeRencontreUseCase.call(CreateDemandeRencontreUseCaseParams(nomPrenoms: nomPrenoms, email: email, telephone: telephone, 
        date: date, objet: objet));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while creating demande rencontre: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating demande rencontre: $e");
      return null;
    }
  }

  Future<EntityDemandeRencontre?> updateDemandeRencontre({required int id, String? nomPrenoms, String? email, String? telephone, 
    String? date, String? objet, String? statut}) async {
    try {
      final result = await updateDemandeRencontreUseCase.call(UpdateDemandeRencontreUseCaseParams(id: id, nomPrenoms: nomPrenoms, email: email, telephone: telephone, 
        date: date, objet: objet, statut: statut));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while updating demande rencontre: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while updating demande rencontre: $e");
      return null;
    }
  }

  Future<VoidType?> deleteDemandeRencontre({required int id}) async {
    try {
      final result = await deleteDemandeRencontreUseCase.call(DeleteDemandeRencontreUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while deleting demande rencontre: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting demande rencontre: $e");
      return null;
    }
  }

}
