import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/functions/widgets_functions.dart';

import '../../../di/controllers_provider.dart' show ControllersProvider;

class DonationUIController extends GetxController {
  
  final donationMessageFormState = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();

  final makeDonationFormState = GlobalKey<FormState>();
  Rx<int> makeDonationAmount = 0.obs;
  RxBool isDonationAnonymous = false.obs;
  final TextEditingController customDonationPriceController = TextEditingController();
  final TextEditingController donorFullnameController = TextEditingController();
  RxString networkDonation = "".obs;

  void updateAnonymousDonation(bool value) {
    isDonationAnonymous.value = value;
    update();
  }

  void updateDonationAmount(int value) {
    makeDonationAmount.value = value;
    customDonationPriceController.text = value.toString();
    update();
  }

  void updateNetworkDonation(String value) {
    networkDonation.value = value;
    update();
  }

  @override
  void onClose() {
    messageController.dispose();
    customDonationPriceController.dispose();
    donorFullnameController.dispose();
    super.onClose();
  }

    RxBool isSubmitting = false.obs;
    Future<void> onSubmit() async {
      if(!makeDonationFormState.currentState!.validate() || makeDonationAmount.value == 0) {
        return;
      }

      final response = await ControllersProvider.DON_CONTROLLER
          .createDon(
            montant: customDonationPriceController.text.isNotEmpty ? int.parse(customDonationPriceController.text) : makeDonationAmount.value,
            anonyme: isDonationAnonymous.value,
            nomAffiche: donorFullnameController.text,
            reseau: networkDonation.value,
          );

      if (response == null) {
        customSnackBar(title: "Une erreur est survenue", message: "Une erreur est survenue, veuillez réessayer", isError: true);
        isSubmitting.value = false;
        update();
        return;
      }

      customSnackBar(title: "Merci de votre don", message: "Votre don a bien ete pris en compte", isError: false);

      isSubmitting.value = true;
      update();
      await Future.delayed(const Duration(seconds: 1));
      isSubmitting.value = false;
      update();
    }
}
