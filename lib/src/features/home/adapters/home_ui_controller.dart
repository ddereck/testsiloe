import 'package:flutter/material.dart'
    show Widget, FormState, GlobalKey, TextEditingController;
import 'package:get/get.dart';

import '../../../di/di_helper.dart' show DiHelper;
import '../../publication/presentation/adapters/publication_ui_controller.dart' show PublicationsUIController;
import '../ui/home_page.dart' show HomePage;
import '../ui/siloe_page.dart' show SiloePage;
import '../ui/widgets/top_header.dart' show SettingsItem;

class HomeUIController extends GetxController {
  final List<Widget> pages = const [
    HomePage(),
    SiloePage(),
  ];

  RxInt tabIndex = 0.obs;
  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  final isSearchLoading = false.obs;
  final searchFormState = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  final publicationsUiController =
        DiHelper.findOrCreate(creator: () => PublicationsUIController());
  Future<void> refreshList() async {
    
    return;
  }

  RxBool showSearch = false.obs;
  void toggleSearch() {
    showSearch.value = !showSearch.value;
    update();
  }

  Rx<SettingsItem?> currentSettingItem = Rx(null);
  void updateCurrentSettingItem(SettingsItem item) {
    currentSettingItem.value = item;
    update();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  RxBool toggleAdminView = false.obs;
  void toggleAdminViewFunction() {
    toggleAdminView.value = !toggleAdminView.value;
    update();
  }
  
}
