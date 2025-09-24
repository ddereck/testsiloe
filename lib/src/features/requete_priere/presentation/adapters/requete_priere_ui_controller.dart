import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../commons/functions/widgets_functions.dart' show customSnackBar;
import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../domain/entities/entity_requete_priere.dart' show EntityRequetePriere;

class RequetePriereUiController extends GetxController {
  final RxList<EntityRequetePriere> adminRequests = <EntityRequetePriere>[].obs;
  void setAdminRequests(List<EntityRequetePriere> requests) {
    adminRequests.value = requests;
    update();
  }

  Future<void> initAdminRequests() async {
    print("initAdminRequests called");
    try {
      print("Calling API...");
      final adRequests = await ControllersProvider.REQUETE_PRIERE_CONTROLLER.getRequetesPriere();
      //print("API response: $adRequests");
      setAdminRequests(adRequests);
    } catch (e) {
      print("Error during API call: $e");
    }
  }

  Future<void> confirmerReception(int requestId) async {
  try {
    await ControllersProvider.REQUETE_PRIERE_CONTROLLER.approuverRequetePriere(id: requestId);
    customSnackBar(
      title: "Confirmation",
      message: "Demande de prière confirmée",
      isError: false,
    );
  } catch (e) {
    customSnackBar(
      title: "Erreur",
      message: "Impossible de confirmer la demande",
      isError: true,
    );
  }
}


Future<void> repondreARequete(int requestId, String message) async {
  try {
    await ControllersProvider.REQUETE_PRIERE_CONTROLLER.repondreRequete(
      id: requestId,
      reponse: message,
    );
    customSnackBar(
      title: "Réponse envoyée",
      message: "Votre réponse a bien été envoyée",
      isError: false,
    );
  } catch (e) {
    customSnackBar(
      title: "Erreur",
      message: "Impossible d’envoyer la réponse",
      isError: true,
    );
  }
}



  
  final sendRequestFormState = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController requestController = TextEditingController();
  RxBool isAnonymousRequest = false.obs;
  RxBool isSubmitting = false.obs;

  Future<void> onSubmit() async {

    if(!sendRequestFormState.currentState!.validate()) {
      return;
    }

    isSubmitting.value = true;
    update();

    final ntAdminRequests = await ControllersProvider.REQUETE_PRIERE_CONTROLLER.createRequetePriere(
      nomPrenom: nameController.text,
      contenu: requestController.text,
      anonyme: isAnonymousRequest.value,
    );

    if (ntAdminRequests == null) {
      customSnackBar(title: "Une erreur est survenue", message: "Une erreur est survenue, veuillez réessayer", isError: true);
      isSubmitting.value = false;
      update();
      return;
    }

    customSnackBar(title: "Merci de votre demande", message: "Votre demande a bien ete prise en compte", isError: false);

    sendRequestFormState.currentState?.reset();
    nameController.clear();
    requestController.clear();
    isAnonymousRequest.value = false;
    isSubmitting.value = false;
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    requestController.dispose();
    super.onClose();
  }
  
}