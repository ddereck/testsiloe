import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/features/home/adapters/home_ui_controller.dart';
import 'package:siloe/src/features/home/ui/widgets/floatting_bottom_nav.dart';
import '../../../../commons/ui/widgets/custom_app_bar.dart';
import '../../../../core/configs/time_config.dart' show TimeConfig;
import '../../../../core/utils/app_constants_utils.dart'
    show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../adapters/evenement_ui_controller.dart'
    show EvenementUIController;
import '../../../../utils/text_config.dart' show TextConfig;

class EvenementsPage extends StatelessWidget {
  // ignore: use_super_parameters
  const EvenementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final evenementUiController =
        DiHelper.findOrCreate(creator: () => EvenementUIController())
          ..initEvenements();
    //
    final now = DateTime.now();

    //
    final homeUiController = DiHelper.findOrCreate(creator: () => HomeUIController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Évènements'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Your existing content goes here...
              ],
            ),
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
