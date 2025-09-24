import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../../commons/ui/widgets/text_field_edit_widget.dart'
    show TextFieldEditWidget;

import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/field_formatter.dart' show FieldFormatter;
import '../../../../utils/text_config.dart' show TextConfig;
import '../adapters/auth_ui_controller.dart' show AuthUIController;

class RegisterUI extends StatelessWidget {
  const RegisterUI({super.key});

  @override
  Widget build(BuildContext context) {
    final authUiController = DiHelper.findOrCreate(
      creator: () => AuthUIController(),
    );
    return GestureDetector(
      behavior: HitTestBehavior
          .opaque, // pour capter les taps même sur les zones vides
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: authUiController.registerFormState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstantsUtils.columnSpacingLarge,
          children: [
            SizedBox(height: AppConstantsUtils.scaffoldWidth(context) * 0.2),
            GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                "Retour",
                style: TextConfig.getSimpleTextStyle(false),
              ),
            ),
            Text(
              "Inscrivez-vous",
              style: TextConfig.getSimpleTextStyle(true,
                  size: AppConstantsUtils.titleSize),
            ),
            TextFieldEditWidget(
              controller: authUiController.emailController,
              inputColor: Theme.of(context).highlightColor,
              hint: "monemail@email.com",
              titleBold: true,
              withTitleWhenTexting: false,
              blocColor: Theme.of(context).highlightColor,
              validator: (value) => FieldFormatter.validatorEmail(value),
            ),
            TextFieldEditWidget(
              controller: authUiController.passwordController,
              inputColor: Theme.of(context).highlightColor,
              hint: "Mot de passe",
              titleBold: true,
              obscure: true,
              withTitleWhenTexting: false,
              blocColor: Theme.of(context).highlightColor,
              validator: (value) => FieldFormatter.validatorPassword(value),
            ),
            TextFieldEditWidget(
              controller: authUiController.passwordConfirmedController,
              inputColor: Theme.of(context).highlightColor,
              hint: "Mot de passe",
              titleBold: true,
              obscure: true,
              withTitleWhenTexting: false,
              blocColor: Theme.of(context).highlightColor,
              validator: (value) => FieldFormatter.validateConfirmedPassword(
                  value, authUiController.passwordController.text),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // couleur du texte
                backgroundColor: Colors.grey.shade900, // couleur de fond
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstantsUtils.radiusMedium),
                ),
                side: const BorderSide(color: Colors.transparent),
              ),
              onPressed: () async => await authUiController.submitRegister(),
              child: Obx(() {
                if (authUiController.isLoginSubmitting.value) {
                  return const CircularProgressIndicator.adaptive();
                }
                return const Text("S'inscrire");
              }),
            ),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Vous avez déjà un compte ?"),
                    Text(
                      "Connectez-vous",
                      style: TextConfig.getSimpleTextStyle(false,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
          ,
    ).paddingSymmetric(horizontal: AppConstantsUtils.scaffoldHPadding)
          .simpleScaffold;
  }
}
