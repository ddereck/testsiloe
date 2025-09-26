import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/ui/widgets/custom_app_bar.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/features/home/adapters/home_ui_controller.dart';
import 'package:siloe/src/features/home/ui/widgets/floatting_bottom_nav.dart';
import 'settings_list_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeUiController = Get.find<HomeUIController>();
    // In a real app, these counts would be fetched from a controller.
    const int demandeRencontresCount = 3;
    const int requetesPriereCount = 3;
    const int donsCount = 9;

    return Scaffold(
      appBar: CustomAppBar(title: 'Paramètres'),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
            children: [
              SettingsListItem(
                title: 'Editeur de la communauté',
                imageAsset: 'assets/images/editors.jpeg',
                onTap: () {
                  RoutesUtils.changePage(AppRoutes.editeurs);
                },
              ),
              SettingsListItem(
                title: 'Les demandes de rencontres',
                subtitle: 'Reverend',
                imageAsset: 'assets/images/rdvs.png',
                notificationCount: demandeRencontresCount,
                onTap: () {
                  RoutesUtils.changePage(AppRoutes.rdvs);
                },
              ),
              SettingsListItem(
                title: 'Requêtes de prière',
                subtitle: 'Reverend',
                imageAsset: 'assets/images/makerequest.jpeg',
                notificationCount: requetesPriereCount,
                onTap: () {
                  RoutesUtils.changePage(AppRoutes.prayerRequestsList);
                },
              ),
              SettingsListItem(
                title: 'Dons',
                subtitle: 'Reverend',
                imageAsset: 'assets/images/dons.jpeg',
                notificationCount: donsCount,
                onTap: () {
                  RoutesUtils.changePage(AppRoutes.adminDonationsList);
                },
              ),
              SettingsListItem(
                title: 'Evenements',
                subtitle: 'Admin',
                imageAsset: 'assets/images/event.jpeg',
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