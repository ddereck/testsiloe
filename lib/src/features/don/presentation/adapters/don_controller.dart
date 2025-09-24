import 'package:get/get.dart';

// UseCases
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/params.dart' show NoParams, VoidType;
import '../../domain/entities/entity_don.dart' show EntityDon;
import '../../domain/usecases/create_don_usecase.dart'
    show CreateDonUseCase, CreateDonUseCaseParams;
import '../../domain/usecases/delete_don_usecase.dart'
    show DeleteDonUseCase, DeleteDonUseCaseParams;
import '../../domain/usecases/fedapay_don_usecase.dart'
    show FedapayCallbackUseCase, FedapayCallbackUseCaseParams;
import '../../domain/usecases/get_don_by_id_usecase.dart'
    show GetDonByIdUseCase, GetDonByIdUseCaseParams;
import '../../domain/usecases/get_dons_admin_usecase.dart'
    show GetDonsAdminUseCase, GetDonsAdminUseCaseParams;
import '../../domain/usecases/get_dons_historique_public_usecase.dart'
    show GetDonsHistoriquePublicUseCase;
import '../../domain/usecases/get_mes_dons_usecase.dart' show GetMesDonsUseCase;

class DonController extends GetxController {
  final GetDonByIdUseCase getDonByIdUseCase;
  final GetDonsHistoriquePublicUseCase getDonsHistoriquePublicUseCase;
  final GetMesDonsUseCase getMesDonsUseCase;
  final GetDonsAdminUseCase getDonsAdminUseCase;
  final DeleteDonUseCase deleteDonUseCase;
  final CreateDonUseCase createDonUseCase;
  final FedapayCallbackUseCase fedapayCallbackUseCase;

  DonController({
    required this.getDonByIdUseCase,
    required this.getDonsHistoriquePublicUseCase,
    required this.getMesDonsUseCase,
    required this.getDonsAdminUseCase,
    required this.deleteDonUseCase,
    required this.createDonUseCase,
    required this.fedapayCallbackUseCase,
  });

  Future<EntityDon?> getDonById(int id) async {
    try {
      final result =
          await getDonByIdUseCase.call(GetDonByIdUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting don by id: ${result.$1.toString()}",
            error: result.$1);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting don by id: $e");
      return null;
    }
  }

  Future<List<EntityDon>> getDonsHistoriquePublic() async {
    try {
      final result = await getDonsHistoriquePublicUseCase.call(NoParams());
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting dons historique public: ${result.$1.toString()}",
            error: result.$1);
        return [];
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger
          .e("Error while getting dons historique public: $e");
      return [];
    }
  }

  Future<List<EntityDon>> getMesDons() async {
    try {
      final result = await getMesDonsUseCase.call(NoParams());
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting mes dons: ${result.$1.toString()}",
            error: result.$1);
        return [];
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting mes dons: $e");
      return [];
    }
  }

  Future<List<EntityDon>> getDonsAdmin(
      {String? status,
      String? reseau,
      bool? anonyme,
      int? utilisateurId}) async {
    try {
      final result = await getDonsAdminUseCase.call(GetDonsAdminUseCaseParams(
          status: status,
          reseau: reseau,
          anonyme: anonyme,
          utilisateurId: utilisateurId));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting dons admin: ${result.$1.toString()}",
            error: result.$1);
        return [];
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting dons admin: $e");
      return [];
    }
  }

  Future<VoidType?> deleteDon(int id) async {
    try {
      final result =
          await deleteDonUseCase.call(DeleteDonUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while deleting don: ${result.$1.toString()}",
            error: result.$1);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting don: $e");
      return null;
    }
  }

  Future<EntityDon?> createDon({
    required String nomAffiche,
    required int montant,
    required String reseau,
    required bool anonyme,
  }) async {
    try {
      final result = await createDonUseCase.call(CreateDonUseCaseParams(
          nomAffiche: nomAffiche,
          montant: montant,
          reseau: reseau,
          anonyme: anonyme));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while creating don: ${result.$1.toString()}",
            error: result.$1);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating don: $e");
      return null;
    }
  }

  Future<VoidType?> fedapayCallback({
    required String transactionId,
    required String status,
    required int montant,
    required int donId,
  }) async {
    try {
      final result =
          await fedapayCallbackUseCase.call(FedapayCallbackUseCaseParams(
        transactionId: transactionId,
        status: status,
        montant: montant,
        donId: donId,
      ));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while fedapay callback: ${result.$1.toString()}",
            error: result.$1);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while fedapay callback: $e");
      return null;
    }
  }
}
