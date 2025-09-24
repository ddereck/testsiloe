import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../domain/entities/entity_don.dart' show EntityDon;

class DonUIController extends GetxController {
  final RxList<EntityDon> adminDons = <EntityDon>[].obs;
  final RxList<EntityDon> notAdminDons = <EntityDon>[].obs;

  // Cette map contient le total des dons par mois (ex: "Juillet 2025" => 2500000)
  final RxMap<String, int> montantsParMoisNtAdmin = <String, int>{}.obs;
  final RxMap<String, int> montantsParMoisAdmin = <String, int>{}.obs;

  void setAdminDons(List<EntityDon> dons) {
    adminDons.value = dons;
    calculerAdminMontantsParMois(); // ⬅️ calcul dès qu'on set les dons
    update();
  }

  void setNotAdminDons(List<EntityDon> dons) {
    notAdminDons.value = dons;
    calculerNotAdminMontantsParMois();
    update();
  }

  Future<void> initAdminDons() async {
    final adDons = await ControllersProvider.DON_CONTROLLER.getDonsAdmin();
    setAdminDons(adDons);
  }

  Future<void> initNtAdminDons() async {
    final ntAdminDons = await ControllersProvider.DON_CONTROLLER.getDonsHistoriquePublic();
    setNotAdminDons(ntAdminDons);
  }

  void calculerAdminMontantsParMois() {
    final Map<String, int> result = {};
    for (final don in adminDons) {
      if (don.montant != null && don.createdAt != null) {
        final date = DateTime.tryParse(don.createdAt!);
        if (date != null) {
          final mois = DateFormat("MMMM yyyy").format(date); // ex: Juillet 2025
          result[mois] = (result[mois] ?? 0) + don.montant!;
        }
      }
    }
    montantsParMoisAdmin.value = result;
  }

  void calculerNotAdminMontantsParMois() {
    final Map<String, int> result = {};
    for (final don in notAdminDons) {
      if (don.montant != null && don.createdAt != null) {
        final date = DateTime.tryParse(don.createdAt!);
        if (date != null) {
          final mois = DateFormat("MMMM yyyy").format(date); // ex: Juillet 2025
          result[mois] = (result[mois] ?? 0) + don.montant!;
        }
      }
    }
    montantsParMoisNtAdmin.value = result;
  }
}
