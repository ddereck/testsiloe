import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../di/di_helper.dart' show DiHelper;
import '../adapters/home_ui_controller.dart' show HomeUIController;
import 'widgets/floatting_bottom_nav.dart' show FloatingBottomNav;

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DiHelper.findOrCreate(creator: () => HomeUIController());

    return Obx(() {
      return Stack(
        children: [
          IndexedStack(
            index: controller.tabIndex.value,
            children: controller.pages,
          ),
          FloatingBottomNav(
            selectedIndex: controller.tabIndex.value,
            onItemTapped: controller.changeTabIndex,
          ),
        ],
      );
    }).emptyScaffold;
  }
}
