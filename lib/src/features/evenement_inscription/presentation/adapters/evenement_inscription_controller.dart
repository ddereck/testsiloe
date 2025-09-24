import 'package:get/get.dart';
import 'package:siloe/src/core/logs/custom_logger.dart';

// UseCases
import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_evenement_inscription.dart' show EntityEvenementInscription;
import '../../domain/usecases/annuler_inscription_usecase.dart' show AnnulerInscriptionUseCase, AnnulerInscriptionUseCaseParams;
import '../../domain/usecases/confirmer_inscription_usecase.dart' show ConfirmerInscriptionUseCase, ConfirmerInscriptionUseCaseParams;
import '../../domain/usecases/get_inscriptions_usecase.dart' show GetInscriptionsUseCase, GetInscriptionsUseCaseParams;
import '../../domain/usecases/inscrire_evenement_usecase.dart' show InscrireEvenementUseCase, InscrireEvenementUseCaseParams;

class EvenementInscriptionController extends GetxController {

  final AnnulerInscriptionUseCase annulerInscriptionUseCase;
  final ConfirmerInscriptionUseCase confirmerInscriptionUseCase;
  final GetInscriptionsUseCase getInscriptionsUseCase;
  final InscrireEvenementUseCase inscrireEvenementUseCase;

  EvenementInscriptionController({
    required this.annulerInscriptionUseCase,
    required this.confirmerInscriptionUseCase,
    required this.getInscriptionsUseCase,
    required this.inscrireEvenementUseCase,
  });

  Future<List<EntityEvenementInscription>> getInscriptions({required int evenementId}) async {
    try {
      final result = await getInscriptionsUseCase.call(GetInscriptionsUseCaseParams(evenementId: evenementId));
      
      if(result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting inscriptions: ${result.$2.toString()}", error: result.$2);
        return [];
      }

      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting inscriptions: $e");
      return [];
    }
  }

  Future<VoidType?> inscrireEvenement(int evenementId, {String? commentaire}) async {
    try {
      final response = await inscrireEvenementUseCase.call(InscrireEvenementUseCaseParams(evenementId :evenementId, commentaire: commentaire));

      if(response.$1 != null) {
        AppLogger.instance.logger.e("Error while inscribing: ${response.$2.toString()}", error: response.$2);
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while inscribing: $e");
      return null;
    }
  }

  Future<VoidType?> annulerInscription({required int evenementId, required int inscriptionId}) async {
    try {
      final response = await annulerInscriptionUseCase.call(AnnulerInscriptionUseCaseParams(evenementId: evenementId, inscriptionId: inscriptionId));

      if(response.$1 != null) {
        AppLogger.instance.logger.e("Error while annuling inscription: ${response.$2.toString()}", error: response.$2);
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while annuling inscription: $e");
      return null;
    }
  }

  Future<VoidType?> confirmerInscription({required int evenementId, required int inscriptionId}) async {
    try {
      final response = await confirmerInscriptionUseCase.call(ConfirmerInscriptionUseCaseParams(evenementId: evenementId, inscriptionId: inscriptionId));

      if(response.$1 != null) {
        AppLogger.instance.logger.e("Error while confirming inscription: ${response.$2.toString()}", error: response.$2);
        return null;
      }

      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while confirming inscription: $e");
      return null;
    }
  }

}
