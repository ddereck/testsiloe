import 'package:flutter/material.dart';
import 'package:siloe/src/commons/ui/widgets/custom_app_bar.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'settings_list_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Using available assets. In a real app, ensure all assets are present.
    const String editeurImage = 'assets/images/reverend.png';
    const String rencontresImage = 'assets/images/events.png';
    const String priereImage = 'assets/images/priere.png';
    const String donsImage = 'assets/images/don.png';
    const String evenementsImage = 'assets/images/events.png';

    return Scaffold(
      appBar: CustomAppBar(title: 'Paramètres'),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SettingsListItem(
            title: 'Editeur de la communauté',
            imageAsset: editeurImage,
            onTap: () {
              RoutesUtils.changePage(AppRoutes.editeurs);
            },
          ),
          SettingsListItem(
            title: 'Les demandes de rencontres',
            subtitle: 'Reverend',
            imageAsset: rencontresImage,
            notificationCount: 3,
            onTap: () {
              RoutesUtils.changePage(AppRoutes.rdvs);
            },
          ),
          SettingsListItem(
            title: 'Requêtes de prière',
            subtitle: 'Reverend',
            imageAsset: priereImage,
            notificationCount: 3,
            onTap: () {
              RoutesUtils.changePage(AppRoutes.prayerRequestsList);
            },
          ),
          SettingsListItem(
            title: 'Dons',
            subtitle: 'Reverend',
            imageAsset: donsImage,
            notificationCount: 9,
            onTap: () {
              RoutesUtils.changePage(AppRoutes.adminDonationsList);
            },
          ),
          SettingsListItem(
            title: 'Evenements',
            subtitle: 'Admin',
            imageAsset: evenementsImage,
            onTap: () {
              RoutesUtils.changePage(AppRoutes.evenements);
            },
          ),
        ],
      ),
    );
  }
}