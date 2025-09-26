import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/ui/widgets/custom_app_bar.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/di/di_helper.dart';
import 'package:siloe/src/features/demande_rencontre/presentation/adapters/demande_rencontre_ui_controller.dart';
import 'package:siloe/src/features/don/presentation/adapters/don_ui_controller.dart';
import 'package:siloe/src/features/home/adapters/home_ui_controller.dart';
import 'package:siloe/src/features/home/ui/widgets/floatting_bottom_nav.dart';
import 'package:siloe/src/features/requete_priere/presentation/adapters/requete_priere_ui_controller.dart';
import 'settings_list_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUiController = DiHelper.findOrCreate(creator: () => HomeUIController());
    final demandeRencontreUiController = DiHelper.findOrCreate(creator: () => DemandeRencontreUiController())..initDemandeRencontres();
    final requetePriereUiController = DiHelper.findOrCreate(creator: () => RequetePriereUiController())..initAdminRequests();
    final donUiController = DiHelper.findOrCreate(creator: () => DonUIController())..initAdminDons();

    return Scaffold(
      appBar: CustomAppBar(title: 'Paramètres'),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
            children: [
              SettingsListItem(
                title: 'Editeur de la communauté',
                imageAsset: 'assets/images/reverend.png',
                onTap: () {
                  RoutesUtils.changePage(AppRoutes.editeurs);
                },
              ),
              Obx(() => SettingsListItem(
                    title: 'Les demandes de rencontres',
                    subtitle: 'Reverend',
                    imageAsset: 'assets/images/events.png',
                    notificationCount: demandeRencontreUiController.allDemandeRencontres.length,
                    onTap: () {
                      RoutesUtils.changePage(AppRoutes.rdvs);
                    },
                  )),
              Obx(() => SettingsListItem(
                    title: 'Requêtes de prière',
                    subtitle: 'Reverend',
                    imageAsset: 'assets/images/priere.png',
                    notificationCount: requetePriereUiController.adminRequests.length,
                    onTap: () {
                      RoutesUtils.changePage(AppRoutes.prayerRequestsList);
                    },
                  )),
              Obx(() => SettingsListItem(
                    title: 'Dons',
                    subtitle: 'Reverend',
                    imageAsset: 'assets/images/don.png',
                    notificationCount: donUiController.adminDons.length,
                    onTap: () {
                      RoutesUtils.changePage(AppRoutes.adminDonationsList);
                    },
                  )),
              SettingsListItem(
                title: 'Evenements',
                subtitle: 'Admin',
                imageAsset: 'assets/images/events.png',
                onTap: () {
                  RoutesUtils.changePage(AppRoutes.eventsAndPrograms);
                },
              ),
            ],
          ),
          Obx(
            () => FloatingBottomNav(
              selectedIndex: homeUiController.tabIndex.value,
              onItemTapped: (index) {
                Get.back();
                homeUiController.changeTabIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}