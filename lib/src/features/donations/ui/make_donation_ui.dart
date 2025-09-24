import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../commons/ui/widgets/text_field_edit_widget.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../di/di_helper.dart' show DiHelper;
import '../../../utils/field_formatter.dart';
import '../../../utils/text_config.dart' show TextConfig;
import '../adapters/datas.dart';
import '../adapters/donation_ui_controller.dart' show DonationUIController;

class MakeDonationUI extends StatelessWidget {
  const MakeDonationUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => DonationUIController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(title: "Dons"),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior
                .opaque, // pour capter les taps même sur les zones vides
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstantsUtils.scaffoldHPadding,
                      vertical: AppConstantsUtils.scaffoldVPadding,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.makeDonationFormState,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: AppConstantsUtils.itemSpacing,
                          children: [
                            Text(
                              "Félicitations",
                              style: TextConfig.getSimpleTextStyle(true,
                                  size: AppConstantsUtils.titleSize),
                            ),
                            Text.rich(
                              TextSpan(
                                text:
                                    "Donnez et il vous sera donné...",
                                style: TextConfig.getSimpleTextStyle(false,
                                    size: 18),
                                children: [
                                  TextSpan(
                                      text: "Luc 6 v 38",
                                      style: TextConfig.getSimpleTextStyle(
                                          false,
                                          size: AppConstantsUtils.smallSize)),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Combien voulez-vous envoyer ?",
                              style: TextConfig.getSimpleTextStyle(false,
                                  size: AppConstantsUtils.titleSize),
                            ),
                            Wrap(
                              spacing: AppConstantsUtils.itemSpacing,
                              runSpacing: AppConstantsUtils.itemSpacing,
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                DonationDatas.donationPrices.length,
                                (index) {
                                  // Calculer la largeur : (largeur totale - espaces) / 3
                                  // Ici on suppose que la largeur disponible est MediaQuery.of(context).size.width
                                  // et on enlève les paddings/marges si besoin
                                  final screenWidth =
                                      MediaQuery.of(context).size.width;
                                  final horizontalPadding = AppConstantsUtils
                                          .scaffoldHPadding *
                                      2; // si tu as un padding horizontal global
                                  final spacingTotal =
                                      AppConstantsUtils.itemSpacing *
                                          2; // 2 espaces entre 3 éléments
                                  final itemWidth = (screenWidth -
                                          horizontalPadding -
                                          spacingTotal) /
                                      3;

                                  return SizedBox(
                                    width: itemWidth,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.resolveWith(
                                                (states) {
                                          if (states
                                              .contains(WidgetState.hovered)) {
                                            return Colors.grey;
                                          } else if (states
                                              .contains(WidgetState.pressed)) {
                                            return Colors.blue;
                                          } else {
                                            return Colors.white;
                                          }
                                        }),
                                        foregroundColor:
                                            WidgetStateProperty.resolveWith(
                                                (states) {
                                          if (states.contains(
                                                  WidgetState.hovered) ||
                                              states.contains(
                                                  WidgetState.pressed)) {
                                            return Colors.white;
                                          } else {
                                            return Colors.black;
                                          }
                                        }),
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppConstantsUtils.radius),
                                          ),
                                        ),
                                        padding: WidgetStateProperty.all(
                                            const EdgeInsets.all(
                                                AppConstantsUtils
                                                    .buttonVPadding)),
                                      ),
                                      onPressed: () {
                                        controller.updateDonationAmount(
                                            DonationDatas
                                                .donationPrices[index]);
                                      },
                                      child: Text(
                                          "${DonationDatas.donationPrices[index]} FCFA"),
                                    ),
                                  );
                                },
                              ),
                            ),
                            TextFieldEditWidget(
                              controller:
                                  controller.customDonationPriceController,
                              inputColor: Theme.of(context).highlightColor,
                              hint: "Montant",
                              withTitleWhenTexting: false,
                              keyboardType: TextInputType.number,
                              blocColor: Theme.of(context).highlightColor,
                              borderColor: Colors.black,
                              validator: (value) =>
                                  FieldFormatter.validatorNumeric(value),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Obx(() {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Checkbox(
                                      value:
                                          controller.isDonationAnonymous.value,
                                      onChanged: (bool? value) {
                                        controller.updateAnonymousDonation(
                                            value ?? false);
                                      },
                                    ),
                                    Text(
                                      "Anonyme",
                                      style:
                                          TextConfig.getSimpleTextStyle(true),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            Text(
                              "Envoyer avec",
                              style: TextConfig.getSimpleTextStyle(false,
                                  size: AppConstantsUtils.titleSize),
                            ),
                            Obx(() {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...List.generate(
                                    DonationDatas.momos.length,
                                    (index) => InkWell(
                                      onTap: () =>
                                          controller.updateNetworkDonation(
                                              DonationDatas.momos[index]),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              AppConstantsUtils.buttonHPadding /
                                                  2,
                                          vertical:
                                              AppConstantsUtils.buttonHPadding /
                                                  2,
                                        ),
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: DonationDatas.momos[index] ==
                                                  controller
                                                      .networkDonation.value
                                              ? Colors.deepPurple
                                              : Colors.grey.shade200,
                                        ),
                                        child: Text(DonationDatas.momos[index],
                                            style:
                                                TextConfig.getSimpleTextStyle(
                                              false, size: 12,
                                              color:
                                                  DonationDatas.momos[index] ==
                                                          controller
                                                              .networkDonation
                                                              .value
                                                      ? Colors.white
                                                      : Colors.black,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            TextFieldEditWidget(
                              controller: controller.donorFullnameController,
                              inputColor: Theme.of(context).highlightColor,
                              hint: "Nom et prénom",
                              withTitleWhenTexting: false,
                              keyboardType: TextInputType.text,
                              blocColor: Theme.of(context).highlightColor,
                              borderColor: Colors.black,
                              validator: (value) =>
                                  FieldFormatter.validatorEmpty(value),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Colors.white, // couleur du texte
                                  backgroundColor:
                                      Colors.grey.shade900, // couleur de fond
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppConstantsUtils.radiusMedium),
                                  ),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                onPressed: () async =>
                                    await controller.onSubmit(),
                                child: Obx(() {
                                  if (controller.isSubmitting.value) {
                                    return const CircularProgressIndicator
                                        .adaptive();
                                  }
                                  return const Text(
                                    "Soumettre",
                                    style: TextStyle(fontSize: 16),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).emptyScaffold;
  }
}
