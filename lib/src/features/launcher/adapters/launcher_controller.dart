import 'package:get/get.dart';

import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../di/controllers_provider.dart' show ControllersProvider;

class LauncherController extends GetxController {
  void redirectToHome({bool skipMaintenance = false}) async {
    final isFirst = ControllersProvider.ONBOARDING_CONTROLLER.isFirstOpening();
    if (isFirst) {
      RoutesUtils.changePage(AppRoutes.onboarding, replace: true);
      return;
    }
    final isSignedIn = ControllersProvider.USER_CONTROLLER.isUserSignedIn();
    RoutesUtils.changePage(isSignedIn ? AppRoutes.home : AppRoutes.login,
        replace: true);
  }
}
