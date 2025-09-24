import 'package:flutter/material.dart';

import '../../../di/controllers_provider.dart' show ControllersProvider;

class LauncherUI extends StatefulWidget {
  const LauncherUI({super.key});

  @override
  State<LauncherUI> createState() => _LauncherUIState();
}

class _LauncherUIState extends State<LauncherUI> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ControllersProvider.LAUNCHER_CONTROLLER.redirectToHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}