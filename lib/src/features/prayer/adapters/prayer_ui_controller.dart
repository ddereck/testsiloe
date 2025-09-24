import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/features/prayer/adapters/datas.dart';

import '../../requete_priere/domain/entities/entity_requete_priere.dart' show EntityRequetePriere;

class PrayerUIController extends GetxController {
  Rx<EntityRequetePriere?> prayerRequest = Rx<EntityRequetePriere?>(null);
  void initPrayerRequest(EntityRequetePriere prayerRequest) {
    this.prayerRequest.value = prayerRequest;
    update();
  }

  void initPrayerRequestByArgs() {
    initPrayerRequest(Get.arguments?[PrayerDatas.prayerRequestArg]);
    update();
  }

  TextEditingController messageController = TextEditingController();

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

}
