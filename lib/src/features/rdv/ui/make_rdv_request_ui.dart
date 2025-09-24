import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../commons/ui/widgets/text_field_edit_widget.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../di/di_helper.dart' show DiHelper;
import '../../../utils/field_formatter.dart';
import '../../demande_rencontre/presentation/adapters/demande_rencontre_ui_controller.dart'
    show DemandeRencontreUiController;

class MakeRdvRequestUI extends StatelessWidget {
  const MakeRdvRequestUI({super.key});

  @override
  Widget build(BuildContext context) {
    final demandeRencontreUiController =
        DiHelper.findOrCreate(creator: () => DemandeRencontreUiController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(
          title: "Rendez-vous",
        ),
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
                  child: Form(
                    key: demandeRencontreUiController.makePrayerFormState,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstantsUtils.scaffoldHPadding,
                        vertical: AppConstantsUtils.scaffoldHPadding,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppConstantsUtils.itemSpacing,
                          children: [
                            Card(
                              elevation: 4,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16)),
                                    child: Image.asset(
                                      'assets/images/priere.png',
                                      width: 120,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Expanded(
                                    child: Text(
                                      "Prise de rendez-vous",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              "Rencontrez le Révérend pour un moment d´écoute, de conseil et de priere",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Text(
                              "Nom et prénoms",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFieldEditWidget(
                              controller: demandeRencontreUiController
                                  .makeRequestFullnameController,
                              inputColor: Theme.of(context).highlightColor,
                              hint: "Vos noms et prenoms",
                              withTitleWhenTexting: false,
                              keyboardType: TextInputType.text,
                              blocColor: Theme.of(context).highlightColor,
                              borderColor: Colors.black,
                              validator: (value) =>
                                  FieldFormatter.validatorEmpty(value),
                            ),
                            const Text(
                              "Numéro de téléphone",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFieldEditWidget(
                              controller: demandeRencontreUiController
                                  .makeRequestPhoneController,
                              inputColor: Theme.of(context).highlightColor,
                              hint: "+229 01 XX XX XX XX",
                              withTitleWhenTexting: false,
                              keyboardType: TextInputType.phone,
                              blocColor: Theme.of(context).highlightColor,
                              borderColor: Colors.black,
                              validator: (value) =>
                                  FieldFormatter.validatorEmpty(value),
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFieldEditWidget(
                              controller: demandeRencontreUiController
                                  .makeRequestEmailController,
                              inputColor: Theme.of(context).highlightColor,
                              hint: "myemail@gmail.com",
                              withTitleWhenTexting: false,
                              keyboardType: TextInputType.emailAddress,
                              blocColor: Theme.of(context).highlightColor,
                              borderColor: Colors.black,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return null; // vide ok
                                }
                                // si non vide, vérifier format
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                                  return "Email invalide";
                                }
                                return null;
                              }
                            ),
                            const Text(
                              "Date de rendez-vous",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Obx(() {
                              return InkWell(
                                onTap: () async {
                                  await demandeRencontreUiController
                                      .selectDate(context);
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConstantsUtils.radius),
                                    border: Border.all(color: Colors.black38),
                                  ),
                                  child: Text(demandeRencontreUiController
                                              .makeRequestDateController
                                              .value !=
                                          null
                                      ? DateFormat('dd-MM-yyyy').format(
                                          demandeRencontreUiController
                                              .makeRequestDateController.value!)
                                      : "JJ - MM - AA"),
                                ),
                              );
                            }),
                            const Text(
                              'Objet',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFieldEditWidget(
                              controller: demandeRencontreUiController
                                  .makeRequestObjectController,
                              inputColor: Theme.of(context).highlightColor,
                              hint: "L´objet de votre demande",
                              minLines: 5,
                              maxLines: 20,
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
                                onPressed: () async {
                                  // Action de soumission
                                  await demandeRencontreUiController
                                      .onSubmitPrayerRequest();
                                },
                                child: Obx(() {
                                  if (demandeRencontreUiController
                                      .isSubmitting.value) {
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
