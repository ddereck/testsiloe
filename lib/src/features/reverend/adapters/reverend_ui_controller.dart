import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../di/controllers_provider.dart' show ControllersProvider;
import '../../../di/di_helper.dart' show DiHelper;
import '../../requete_priere/presentation/adapters/requete_priere_ui_controller.dart';
import '../../demande_rencontre/presentation/adapters/demande_rencontre_ui_controller.dart'
    show DemandeRencontreUiController;
import '../../don/presentation/adapters/don_ui_controller.dart'
    show DonUIController;
import '../../user/domain/entities/entity_user.dart' show EntityUser;

class ReverendUIController extends GetxController {
  final RxInt rdvCount = 0.obs;
  final RxInt prayerRequestCount = 0.obs;
  final RxInt donationCount = 0.obs;

  RxList<EntityUser> allUsers = <EntityUser>[].obs;

  final searchFormState = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadCounts();
    initUsers();
  }

Future<void> loadCounts() async {
  try {
    print("Chargement des compteurs...");

    final rdvController = DiHelper.findOrCreate(creator: () => DemandeRencontreUiController());
    final prayerController = DiHelper.findOrCreate(creator: () => RequetePriereUiController());
    final donationController = DiHelper.findOrCreate(creator: () => DonUIController());

    print("Initialisation des données...");
    await rdvController.initDemandeRencontres();
    await prayerController.initAdminRequests();
    await donationController.initAdminDons();

    print("Calcul des longueurs...");
    rdvCount.value = rdvController.allDemandeRencontres.length;
    prayerRequestCount.value = prayerController.adminRequests.length;
    donationCount.value = donationController.adminDons.length;

    print("Comptes chargés : RDV=${rdvCount.value}, Prières=${prayerRequestCount.value}, Dons=${donationCount.value}");
  } catch (e, stack) {
    print("Erreur lors du chargement des compteurs : $e");
    print(stack);
  }
}


  Future<void> onSearch() async {
    try {
      final users = await ControllersProvider.USER_CONTROLLER.getAllUsers(
        search: searchController.text,
      );
      allUsers.value = users;
      update();
    } catch (e) {
      print("Erreur onSearch : $e");
    }
  }

  Future<void> initUsers() async {
    try {
      final users = await ControllersProvider.USER_CONTROLLER.getAllUsers();
      allUsers.value = users;
      update();
    } catch (e) {
      print("Erreur initUsers : $e");
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
