import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../commons/ui/widgets/text_field_edit_widget.dart';
import '../../commons/ui/widgets/topbar_widget.dart';
import '../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../di/di_helper.dart' show DiHelper;
import '../../utils/field_formatter.dart';
import '../categorie/domain/entities/entity_categorie.dart'
    show EntityCategorie;
import '../categorie/presentation/adapters/categorie_ui_controller.dart'
    show CategorieUIController;
import '../publication_type/domain/entities/entity_publication_type.dart'
    show EntityPublicationType;
import '../publication_type/presentation/adapters/publication_type_ui_controller.dart'
    show PublicationTypesUIController;
import 'adapters/upsert_event_ui_controller.dart' show UpsertEventUIController;

class UpsertEventUI extends StatelessWidget {
  const UpsertEventUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => UpsertEventUIController())
          ..initEventByArg();
    final categorieUiController =
        DiHelper.findOrCreate(creator: () => CategorieUIController())
          ..initCategories();
    final publicationTypesUIController =
        DiHelper.findOrCreate(creator: () => PublicationTypesUIController())
          ..initPublicationTypes();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(title: "Evènements"),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior
                .opaque, // pour capter les taps même sur les zones vides
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: controller.upsertEventFormState,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppConstantsUtils.itemSpacing,
                  children: [
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppConstantsUtils.itemSpacing,
                        children: [
                          Text("Image de couverture",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () async {
                              await controller.pickFile();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppConstantsUtils.radius),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: AppConstantsUtils.itemSpacingDualSide,
                                children: [
                                  Icon(TablerIcons.paperclip),
                                  Expanded(
                                    child: Text(controller
                                            .currentCoverFile.value?.path ??
                                        "Sélectionnez le média"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (controller.currentCoverFile.value != null) ...[
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black12,
                              ),
                              child: Image.file(
                                controller.currentCoverFile.value!,
                                width: double.infinity,
                                frameBuilder: (BuildContext context,
                                    Widget child,
                                    int? frame,
                                    bool? wasSynchronouslyLoaded) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: child,
                                  );
                                },
                                errorBuilder: (context, url, error) =>
                                    const Icon(Icons.broken_image, size: 40),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ],
                      );
                    }),
                    Text("Theme de la publication",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.themeController,
                      inputColor: Theme.of(context).highlightColor,
                      hint: "Saisir le theme de la publication",
                      withTitleWhenTexting: false,
                      blocColor: Theme.of(context).highlightColor,
                      validator: (value) =>
                          FieldFormatter.validatorEmpty(value),
                    ),
                    Obx(() {
                      return Row(
                        spacing: AppConstantsUtils.itemSpacing,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date de l´évenement",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () async {
                                  await controller.selectEventDate(context,
                                      isDebut: true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConstantsUtils.radius),
                                    border: Border.all(color: Colors.black38),
                                  ),
                                  child: Text(
                                      controller.eventDateDebut.value != null
                                          ? controller.dateFormat.format(
                                              controller.eventDateDebut.value!)
                                          : "JJ - MM - AA"),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Heure",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () async {
                                  await controller.pickTime(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConstantsUtils.radius),
                                    border: Border.all(color: Colors.black38),
                                  ),
                                  child: Text(controller.hourDate.value != null
                                      ? controller.hourDate.value!
                                          .format(context)
                                      : "--:--"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    Text("Informations",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.infoController,
                      withEraser: false,
                      withRadius: true,
                      inputColor: Theme.of(context).highlightColor,
                      hint: "Saisir informations",
                      titleBold: true,
                      bold: true,
                      minLines: 5,
                      maxLines: 20,
                      withTitleWhenTexting: false,
                      blocColor: Theme.of(context).highlightColor,
                      validator: (value) =>
                          FieldFormatter.validatorEmpty(value),
                    ),
                    Obx(() {
                      if (categorieUiController.categories.value.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Catégorie",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Obx(() {
                              return DropdownButtonFormField<EntityCategorie>(
                                decoration: InputDecoration(
                                  hintText: "Catégorie d'article",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppConstantsUtils.radius),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 14),
                                ),
                                value: controller.selectedCategory.value,
                                items: categorieUiController.categories.value
                                    .where((e) => e.nomCategorie != null)
                                    .map((category) {
                                  return DropdownMenuItem<EntityCategorie>(
                                    value: category,
                                    child: Text(category.nomCategorie ?? "_"),
                                  );
                                }).toList(),
                                onChanged: (EntityCategorie? newValue) =>
                                    controller.selectCategory(newValue!),
                                validator: (value) => value == null
                                    ? "Veuillez sélectionner une catégorie"
                                    : null,
                              );
                            }),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    // Dropdown pour le type de publication
                    Obx(() {
                      if (publicationTypesUIController
                          .publicationsTypes.value.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text("Type de publication",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          DropdownButtonFormField<EntityPublicationType>(
                            decoration: InputDecoration(
                                hintText: "Type de publication",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppConstantsUtils.radius),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                                fillColor: Colors.red),
                            value: controller.selectedContentType.value,
                            items: publicationTypesUIController
                                .publicationsTypes.value
                                .where((e) => e.typePublication != null)
                                .map((category) {
                              return DropdownMenuItem<EntityPublicationType>(
                                value: category,
                                child: Text(category.typePublication ?? "_"),
                              );
                            }).toList(),
                            onChanged: (EntityPublicationType? newValue) {
                              controller.selectedContentType.value = newValue;
                            },
                            validator: (value) => value == null
                                ? "Veuillez sélectionner un type d'article"
                                : null,
                          ),
                        ],
                      );
                    }),
                    Text("Nombre de places",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.placeCounterController,
                      inputColor: Theme.of(context).highlightColor,
                      hint: "0",
                      withTitleWhenTexting: false,
                      blocColor: Theme.of(context).highlightColor,
                      validator: (value) =>
                          FieldFormatter.validatorNumeric(value),
                      keyboardType: TextInputType.number,
                    ),
                    Text("Lieu de rendez-vous",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.lieuController,
                      inputColor: Theme.of(context).highlightColor,
                      hint: "Lieu de rendez-vous",
                      withTitleWhenTexting: false,
                      blocColor: Theme.of(context).highlightColor,
                      validator: (value) =>
                          FieldFormatter.validatorEmpty(value),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, // couleur du texte
                          backgroundColor:
                              Colors.grey.shade900, // couleur de fond
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppConstantsUtils.radiusMedium),
                          ),
                          side: const BorderSide(color: Colors.transparent),
                        ),
                        onPressed: () async => await controller.onSubmit(),
                        child: Obx(() {
                          if (controller.isSubmitting.value) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return const Text("Partager");
                        }),
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width / 3)
                  ],
                ),
              ),
            ).paddingSymmetric(
              horizontal: AppConstantsUtils.scaffoldHPadding,
            ),
          ),
        ),
      ],
    ).emptyScaffold;
  }
}
