import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../core/utils/routes_utils.dart' show AppRoutes;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/text_config.dart' show TextConfig;
import '../adapters/auth_ui_controller.dart' show AuthUIController;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    final authUiController = DiHelper.findOrCreate(
      creator: () => AuthUIController(),
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "S'IDENTIFIER",
            style: TextConfig.getSimpleTextStyle(true,
                size: AppConstantsUtils.titleSize,
                color: const Color(0xFF861E0C)),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: AppConstantsUtils.scaffoldWidth(context) * 0.8,
            child: InkWell(
              onTap: () async => await authUiController.submitLoginWithGoogle(),
              borderRadius:
                  BorderRadius.circular(AppConstantsUtils.radiusMedium),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppConstantsUtils.radiusMedium),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 48,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/google_g.png',
                        width: 22,
                        height: 22,
                        errorBuilder: (_, __, ___) => const Icon(
                          TablerIcons.brand_google,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 48,
                        color: const Color(0xFF4285F4),
                        alignment: Alignment.center,
                        child:
                            Obx(() => authUiController.isGoogleSubmitting.value
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Continuer avec Google",
                                    style: TextStyle(color: Colors.white),
                                  )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: AppConstantsUtils.scaffoldWidth(context) * 0.8,
            child: InkWell(
              onTap: () async => await authUiController.submitLoginWithApple(),
              borderRadius:
                  BorderRadius.circular(AppConstantsUtils.radiusMedium),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppConstantsUtils.radiusMedium),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 48,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/apple.png',
                        width: 22,
                        height: 22,
                        errorBuilder: (_, __, ___) => const Icon(TablerIcons.brand_apple,
                          color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 48,
                        color: Colors.black,
                        alignment: Alignment.center,
                        child:
                            Obx(() => authUiController.isAppleSubmitting.value
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Continuer avec Apple",
                                    style: TextStyle(color: Colors.white),
                                  )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: AppConstantsUtils.scaffoldWidth(context) * 0.8,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                side: const BorderSide(color: Colors.black12),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstantsUtils.radiusMedium),
                ),
              ),
              onPressed: () {
                Get.offAllNamed(AppRoutes.home);
              },
              child: const Text('Continuer sans se connecter'),
            ),
          ),
        ],
      ),
    )
        .paddingSymmetric(horizontal: AppConstantsUtils.scaffoldHPadding)
        .simpleScaffold;
  }
}
