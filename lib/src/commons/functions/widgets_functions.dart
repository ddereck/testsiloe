import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../core/utils/app_constants_utils.dart' show AppConstantsUtils;

void customSnackBar({required String title, required String message, bool isError = false, 
  bool isConnectivityError = false, bool? isDismissible, Icon? icon,
}) {
  Get.snackbar(
    title, 
    message,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.BOTTOM,
    icon: icon ?? (isError ? const Icon(TablerIcons.circle_x_filled, color: Colors.red) 
      : isConnectivityError ? 
        const Icon(TablerIcons.wifi_off, color: Colors.white)
        : const Icon(TablerIcons.circle_check_filled, color: Color.fromARGB(255, 255, 255, 255),)),
    backgroundColor: isError ? Colors.red : Color.fromARGB(255, 0, 0, 0),
    colorText: isError ? Colors.white : Color.fromARGB(255, 255, 255, 255),
    borderRadius: AppConstantsUtils.radius,
    isDismissible: isDismissible,
  );
}