import 'package:get/get.dart';
import 'package:siloe/src/commons/functions/widgets_functions.dart';
import 'package:siloe/src/di/controllers_provider.dart';

import '../../domain/entities/entity_evenement.dart' show EntityEvenement;

class EvenementUIController extends GetxController {
  final isLoading = false.obs;
  Rx<List<EntityEvenement>> evenements = Rx<List<EntityEvenement>>([]);

  void setEvenements(List<EntityEvenement> evenements) {
    this.evenements.value = evenements;
    update();
  }

  Future<void> initEvenements() async {
    isLoading.value = true;
    final result =
        await ControllersProvider.EVENEMENT_CONTROLLER.getAllEvenements();
    setEvenements(result);
    isLoading.value = false;
  }

  Future<void> onRefresh() async => await initEvenements();

  Future<void> deleteEvent({required EntityEvenement evenement}) async {
    if (evenement.id == null) return;
    final result = await ControllersProvider.EVENEMENT_CONTROLLER.deleteEvenement(id: evenement.id!);
    if(result != null) {
      await initEvenements();
      return;
    }
    customSnackBar(title: "Une error est survenue", message: "Une erreur est survenue, veuillez réessayer", isError: true);
  }
}