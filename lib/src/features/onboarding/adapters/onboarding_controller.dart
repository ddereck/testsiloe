import 'package:get/get.dart';

import '../../../core/services/preferences_service.dart' show PreferencesServices;

class OnboardingController extends GetxController {

  RxInt currentPage = 0.obs;

  Future<void> updateFirstOpening(bool value) async {
    await PreferencesServices.saveData(PreferencesServices.firstOpeningKey, value);
  }

  bool isFirstOpening() {
    return PreferencesServices.getValue(PreferencesServices.firstOpeningKey) ?? true;
  }
  
}