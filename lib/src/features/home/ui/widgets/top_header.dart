import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../core/utils/routes_utils.dart' show AppRoutes, RoutesUtils;
import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../core/resources/firebase_resources.dart'
    show FirebaseResources;
import '../../../authentication/presentation/adapters/auth_ui_controller.dart'
    show AuthUIController;
import '../../adapters/home_ui_controller.dart' show HomeUIController;

enum SettingsItem {
  user(label: "Utilisateur", icon: TablerIcons.user),
  editeurs(label: "Editeurs", icon: TablerIcons.users_group),
  reverend(label: "Révérend", icon: TablerIcons.user_square),
  //administration(label: "Administration", icon: TablerIcons.settings),
  // communuty(label: "Communauté", icon: TablerIcons.users_group),
  login(label: "Connexion", icon: TablerIcons.login),
  logout(label: "Deconnexion", icon: TablerIcons.logout),
  ;

  final String label;
  final IconData icon;
  const SettingsItem({required this.label, required this.icon});
}




class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  Future<void> onSelectedItem(
      BuildContext context,
      SettingsItem value,
      AuthUIController authUiController,
      HomeUIController homeUiController) async {
    switch (value) {
      // case SettingsItem.administration:
      //   homeUiController.toggleAdminViewFunction();
      //   break;
      case SettingsItem.logout:
        await authUiController.submitLogout();
        break;
      case SettingsItem.user:
        Navigator.pushNamed(context, '/user');
        break;
      case SettingsItem.editeurs:
        RoutesUtils.changePage(AppRoutes.editeurs);
        break;
      case SettingsItem.reverend:
        RoutesUtils.changePage(AppRoutes.reverend);
        break;
      case SettingsItem.login:
        RoutesUtils.changePage(AppRoutes.login);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUiController = DiHelper.findOrCreate(
      creator: () => AuthUIController(),
    );

    final homeUiController = DiHelper.findOrCreate(
      creator: () => HomeUIController(),
    );
    ImageProvider _buildUserAvatar() {
      final firebasePhoto = FirebaseResources.currentUser?.photoURL;
      final backendPhoto =
          ControllersProvider.USER_CONTROLLER.user.value?.photo;
      const ImageProvider defaultAvatar =
          AssetImage('assets/images/avatar_male.png');

      if (firebasePhoto != null && firebasePhoto.isNotEmpty) {
        return NetworkImage(firebasePhoto);
      }
      if (backendPhoto != null && backendPhoto.isNotEmpty) {
        return NetworkImage(backendPhoto);
      }
      return defaultAvatar;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Row(
            children: [
              Image.asset('assets/images/logo.png', height: 50),
            ],
          ),

          const Spacer(),

          // Icône de don
          InkWell(
            onTap: () => RoutesUtils.changePage(AppRoutes.sendDonation),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                const Text(
                  "Faire un don",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
                const Icon(TablerIcons.gift, color: Colors.red, size: 28),
                const SizedBox(height: 4),
              ],
            ),
          ),

          const Spacer(),


          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: _buildUserAvatar(),
                  backgroundColor: Colors.transparent,
                ),
                Obx(() {
                  if (!authUiController.isCurrentlyLogin.value) {
                    return PopupMenuButton<SettingsItem>(
                      icon: Icon(TablerIcons.chevron_down),
                      onSelected: (SettingsItem item) async =>
                          await onSelectedItem(context, item, authUiController,
                              homeUiController),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<SettingsItem>(
                            value: SettingsItem.login,
                            child: Row(
                              spacing: 8.0,
                              children: [
                                Icon(SettingsItem.login.icon),
                                Text(SettingsItem.login.label),
                              ],
                            ),
                          ),
                        ];
                      },
                    );
                  }
                  return PopupMenuButton<SettingsItem>(
                    icon: Icon(TablerIcons.chevron_down),
                    onSelected: (SettingsItem item) async =>
                        await onSelectedItem(
                            context, item, authUiController, homeUiController),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    itemBuilder: (BuildContext context) {
                      final itemsWithoutLogin = SettingsItem.values
                          .where((item) => item != SettingsItem.login)
                          .toList();
                      // Temporarily commented for testing purposes
                      if (!(ControllersProvider.USER_CONTROLLER.userRole.value
                          ?.isAdminOrReverend ??
                          false)) {
                        itemsWithoutLogin.remove(SettingsItem.editeurs);
                        itemsWithoutLogin.remove(SettingsItem.reverend);
                      }
                      return itemsWithoutLogin.map((item) {
                        // Check if user is connected or not
                        return PopupMenuItem<SettingsItem>(
                          value: item,
                          child: item == SettingsItem.user
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  spacing: AppConstantsUtils.itemSpacing,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: _buildUserAvatar(),
                                      backgroundColor: Colors.transparent,
                                    ),
                                    Expanded(
                                      child: Obx(() {
                                        if (authUiController
                                            .isCurrentlyLogin.value) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              if (ControllersProvider
                                                      .USER_CONTROLLER
                                                      .user
                                                      .value
                                                      ?.name !=
                                                  null) ...[
                                                Text(
                                                    ControllersProvider
                                                            .USER_CONTROLLER
                                                            .user
                                                            .value
                                                            ?.name ??
                                                        "-",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                              if (ControllersProvider
                                                      .USER_CONTROLLER
                                                      .user
                                                      .value
                                                      ?.email !=
                                                  null) ...[
                                                Text(
                                                    ControllersProvider
                                                            .USER_CONTROLLER
                                                            .user
                                                            .value
                                                            ?.email ??
                                                        "-",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                              if (ControllersProvider
                                                      .USER_CONTROLLER
                                                      .user
                                                      .value
                                                      ?.tel !=
                                                  null) ...[
                                                Text(
                                                    ControllersProvider
                                                            .USER_CONTROLLER
                                                            .user
                                                            .value
                                                            ?.tel ??
                                                        "-",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ],
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      }),
                                    ),
                                  ],
                                )
                              : Row(
                                  spacing: 8.0,
                                  children: [
                                    Icon(item.icon),
                                    Text(item.label),
                                  ],
                                ),
                        );
                      }).toList();
                    },
                  );
                }),
              ],
            ),
            Obx(() {
              if (authUiController.isCurrentlyLogin.value) {
                final userName = ControllersProvider.USER_CONTROLLER.user.value?.name;
                if (userName == null) return const SizedBox.shrink();

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20), // marge fixe
                  constraints: const BoxConstraints(maxWidth: 80),   // largeur max
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }
              return const SizedBox.shrink();
              }),
            ],
          ),
        ],
      ),
    );
  }
}

