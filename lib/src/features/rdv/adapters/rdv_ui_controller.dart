import 'package:get/get.dart';
import '../../../commons/functions/widgets_functions.dart' show customSnackBar;
import '../../demande_rencontre/domain/entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../../../di/controllers_provider.dart' show ControllersProvider;

class RdvUIController extends GetxController {
  final RxBool isProcessing = false.obs;
  final RxList<EntityDemandeRencontre> rdvRequest = <EntityDemandeRencontre>[].obs;

  /// Charger mes demandes
  Future<void> initDemandeRencontres() async {
    try {
      final rdvs = await ControllersProvider.DEMANDE_RENCONTRE_CONTROLLER.getMesDemandesRencontre();
      rdvRequest.assignAll(rdvs);
    } catch (e) {
      customSnackBar(
        title: "Erreur",
        message: "Impossible de charger les demandes : $e",
        isError: true,
      );
    }
  }

  /// Confirmer un rendez-vous
  Future<void> confirmerRdv(EntityDemandeRencontre rdv) async {
    if (rdv.id == null) return;

    isProcessing.value = true;
    update();

    try {
      final result = await ControllersProvider.DEMANDE_RENCONTRE_CONTROLLER
          .accepterDemandeRencontre(id: rdv.id!);

      if (result != null) {
        _updateRdvInList(result);
        customSnackBar(
          title: "Confirmation réussie",
          message: "Le rendez-vous a été confirmé.",
          isError: false,
        );
      } else {
        customSnackBar(
          title: "Erreur",
          message: "Impossible de confirmer le rendez-vous.",
          isError: true,
        );
      }
    } catch (e) {
      customSnackBar(
        title: "Erreur",
        message: "Une erreur est survenue : $e",
        isError: true,
      );
    } finally {
      isProcessing.value = false;
      update();
    }
  }

  /// Annuler un rendez-vous
  Future<void> annulerRdv(EntityDemandeRencontre rdv) async {
    if (rdv.id == null) return;

    isProcessing.value = true;
    update();

    try {
      final result = await ControllersProvider.DEMANDE_RENCONTRE_CONTROLLER
          .refuserDemandeRencontre(id: rdv.id!);

      if (result != null) {
        _updateRdvInList(result);
        customSnackBar(
          title: "Annulation réussie",
          message: "Le rendez-vous a été annulé.",
          isError: false,
        );
      } else {
        customSnackBar(
          title: "Erreur",
          message: "Impossible d'annuler le rendez-vous.",
          isError: true,
        );
      }
    } catch (e) {
      customSnackBar(
        title: "Erreur",
        message: "Une erreur est survenue : $e",
        isError: true,
      );
    } finally {
      isProcessing.value = false;
      update();
    }
  }

  /// Met à jour un RDV dans la liste
  void _updateRdvInList(EntityDemandeRencontre updatedRdv) {
    final index = rdvRequest.indexWhere((r) => r.id == updatedRdv.id);
    if (index != -1) {
      rdvRequest[index] = updatedRdv;
    }
  }
}
