import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/core/resources/firebase_resources.dart';
import 'package:siloe/src/core/utils/app_constants_utils.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/di/di_helper.dart';
import 'package:siloe/src/features/authentication/presentation/adapters/auth_ui_controller.dart';
import 'package:siloe/src/features/home/adapters/home_ui_controller.dart';


enum SettingsItem {
  user(label: "Utilisateur", icon: TablerIcons.user),
  settings(label: "Paramètres", icon: TablerIcons.settings),
  login(label: "Connexion", icon: TablerIcons.login),
  logout(label: "Deconnexion", icon: TablerIcons.logout),
  ;

  final String label;
  final IconData icon;
  const SettingsItem({required this.label, required this.icon});
}
class TopBarWidget extends StatelessWidget {
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
      AssetImage('assets/images/avatar.jpg');

      if (firebasePhoto != null && firebasePhoto.isNotEmpty) {
        return NetworkImage(firebasePhoto);
      }
      if (backendPhoto != null && backendPhoto.isNotEmpty) {
        return NetworkImage(backendPhoto);
      }
      return defaultAvatar;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Partie gauche : Logo et texte
          Image.asset('assets/images/logo.png', height: 50),


          // Icône de don
          InkWell(
            onTap: () => RoutesUtils.changePage(AppRoutes.sendDonation),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                const Text(
                  "Faire un don",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Image.asset('assets/images/donicon.jpeg', height: 30),
                //const Icon(TablerIcons.gift, color: Colors.red, size: 28),
                const SizedBox(height: 4),
              ],
            ),
          ),

          // Partie droite : Avatar, nom et PopupMenuButton
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          itemsWithoutLogin.remove(SettingsItem.settings);
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

                  return Text(
                    userName.length > 10 ? "${userName.substring(0, 10)}..." : userName,
                    style: const TextStyle(fontSize: 13,color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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

  Future<void> onSelectedItem(
      BuildContext context,
      SettingsItem value,
      AuthUIController authUiController,
      HomeUIController homeUiController) async {
    print("ddddddddddd");
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
      case SettingsItem.settings:
        RoutesUtils.changePage(AppRoutes.settings);
        break;
      case SettingsItem.login:
        RoutesUtils.changePage(AppRoutes.login);
        break;
    }
  }
}