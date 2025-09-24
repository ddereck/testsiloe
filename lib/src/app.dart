import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bindings/app_bindings.dart' show AppBinding;
import 'commons/ui/custom_error_widget.dart';
import 'core/utils/routes_utils.dart' show AppRoutes, getPages;
import 'services/app_mode_service.dart' show AppModeService;
import 'services/app_themes_service.dart' show AppThemesService;
import 'utils/app_strings.dart' show AppStrings;

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});
  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Observer pour détecter si l'application entre au premier plan
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppThemesService.lightThemeData,
      darkTheme: AppThemesService.darkThemeData,
      themeMode: AppModeService.getAppThemeMode(),
      initialRoute: AppRoutes.launcher,
      initialBinding: AppBinding(),
      getPages: getPages,
      builder: (context, child) {
        FlutterError.onError = (FlutterErrorDetails details) {
          ErrorWidget.builder = (details) {
            return CustomErrorUI(details: details);
          };
        };

        ErrorWidget.builder = (FlutterErrorDetails details) {
          return CustomErrorUI(details: details);
        };
        return child!;
      },
    );
  }
}
