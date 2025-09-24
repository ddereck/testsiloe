import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../../commons/ui/widgets/menu_card.dart' show MenuCard;
import '../../../../commons/ui/widgets/text_field_edit_widget.dart'
    show TextFieldEditWidget;
import '../../../../commons/ui/widgets/topbar_widget.dart' show TopbarWidget;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../../utils/field_formatter.dart' show FieldFormatter;
import '../../../../utils/text_config.dart' show TextConfig;
import '../../../article/adapters/upsert_article_ui_controller.dart'
    show UpsertArticleUIController;
import '../../../categorie/domain/entities/entity_categorie.dart'
    show EntityCategorie;
import '../../../categorie/presentation/adapters/categorie_ui_controller.dart'
    show CategorieUIController;
import '../../../publication_type/domain/entities/entity_publication_type.dart'
    show EntityPublicationType;
import '../../../publication_type/presentation/adapters/publication_type_ui_controller.dart'
    show PublicationTypesUIController;

class UpdateArticleUI extends StatelessWidget {
  const UpdateArticleUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => UpsertArticleUIController())
          ..initPublication();
//          ..initControllers();

    //
    final categorieUiController =
        DiHelper.findOrCreate(creator: () => CategorieUIController())
          ..initCategories();
    final publicationTypesUIController =
        DiHelper.findOrCreate(creator: () => PublicationTypesUIController())
          ..initPublicationTypes();

      controller.initControllers(publicationTypesUIController);

      if (categorieUiController.categories.value.isNotEmpty) {
        controller.iniCategoryController(categorieUiController.categories.value);
      }

      if (publicationTypesUIController.publicationsTypes.value.isNotEmpty) {
        controller.iniContentTypeController(publicationTypesUIController.publicationsTypes.value);
      }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(title: "Modifier publication"),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior
                .opaque, // pour capter les taps même sur les zones vides
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: controller.updateArticleFormState,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppConstantsUtils.itemSpacing,
                  children: [
                    MenuCard(
                      title: "Modifier une publication",
                      imagePath: "assets/images/reverend.png",
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
                      if (publicationTypesUIController.publicationsTypes.value.isNotEmpty) {
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
                              controller.update();
                            },
                            validator: (value) => value == null
                                ? "Veuillez sélectionner un type d'article"
                                : null,
                          ),
                        ],
                      );
                      }
                      return const SizedBox.shrink();
                    }),
                    // Dropdown pour la catégorie
                    Text("Titre de la publication",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.titleController,
                      inputColor: Theme.of(context).highlightColor,
                      hint: "Saisir le titre de la publication",
                      withTitleWhenTexting: false,
                      keyboardType: TextInputType.text,
                      blocColor: Theme.of(context).highlightColor,
                      validator: (value) =>
                          FieldFormatter.validatorEmpty(value),
                    ),
                    Text("Description ou contenu de la publication",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.contentController,
                      inputColor: Theme.of(context).highlightColor,
                      hint:
                          "Saisir le contenu ou description de la publication",
                      withTitleWhenTexting: false,
                      keyboardType: TextInputType.text,
                      blocColor: Theme.of(context).highlightColor,
                      validator: (value) =>
                          FieldFormatter.validatorEmpty(value),
                      minLines: 3,
                      maxLines: 50,
                    ),
                    // Champs dynamiques selon le type de publication
                    Obx(() {
                      final type = controller
                          .selectedContentType.value?.typePublication
                          ?.toLowerCase();

                      if (type == 'video') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lien Youtube",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextFieldEditWidget(
                              controller: controller.urlController,
                              inputColor: Theme.of(context).highlightColor,
                              hint: "https://youtube.com/...",
                              withTitleWhenTexting: false,
                              keyboardType: TextInputType.url,
                              blocColor: Theme.of(context).highlightColor,
                              validator: (value) =>
                                  FieldFormatter.validatorUrl(value),
                            ),
                          ],
                        );
                      } else if (type == 'audio') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Fichier Audio", style: TextStyle(fontWeight: FontWeight.bold)),
                            if (controller.audioFile.value != null) ...[
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black12,
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.audiotrack, color: Colors.blue),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        controller.audioFile.value!.path.split('/').last,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            InkWell(
                              onTap: () async => await controller.pickAudio(),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  children: [
                                    Icon(TablerIcons.paperclip),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        controller.audioFile.value?.path ??
                                            "Sélectionnez un fichier audio (mp3, wav...)",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (controller.fileNotPicked.value) ...[
                              Text(
                                "Veuillez choisir un fichier audio",
                                style: TextConfig.getSimpleTextStyle(false,
                                    color: Colors.red),
                              ),
                            ],
                          ],
                        );
                      } else if (type == 'article') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rédigez votre article",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextFieldEditWidget(
                              controller: controller.textArticleController,
                              inputColor: Theme.of(context).highlightColor,
                              hint:
                                  "Saisir la rédaction complète de votre article",
                              withTitleWhenTexting: false,
                              keyboardType: TextInputType.multiline,
                              blocColor: Theme.of(context).highlightColor,
                              validator: (value) =>
                                  FieldFormatter.validatorEmpty(value),
                              minLines: 6,
                              maxLines: 200,
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Aucun champ dynamique si rien sélectionné
                      }
                    }),
                    Text("Nom & prénom de l'auteur",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.authorController,
                      inputColor: Theme.of(context).highlightColor,
                      hint: "Saisir le nom & prénom de l'auteur",
                      withTitleWhenTexting: false,
                      blocColor: Theme.of(context).highlightColor,
                      keyboardType: TextInputType.name,
                      validator: (value) =>
                          FieldFormatter.validatorEmpty(value),
                    ),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text("Image de couverture",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          if (controller.coverImageFile.value != null) ...[
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black12,
                              ),
                              child: Image.file(
                                controller.coverImageFile.value!,
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
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                          InkWell(
                            onTap: () async {
                              await controller.pickCoverImage();
                            },
                            child: Container(
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
                                    child: Text(
                                        controller.coverImageFile.value?.path ??
                                            "Sélectionnez un média"),
                                  )
                                ],
                              ),
                            ),
                          ),

                          //
                          if (controller.fileNotPicked.value) ...[
                            Text(
                              "Veuillez choisir une image de couverture",
                              style: TextConfig.getSimpleTextStyle(false,
                                  color: Colors.red),
                            ),
                          ],
                        ],
                      );
                    }),
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
                        onPressed: () async =>
                            await controller.onSubmitUpdate(),
                        child: Obx(() {
                          if (controller.isSubmitting.value) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return const Text("Publier");
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
