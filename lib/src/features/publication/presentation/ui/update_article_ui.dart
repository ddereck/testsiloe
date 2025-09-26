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

class UpdateArticleUI extends StatefulWidget {
  const UpdateArticleUI({super.key});

  @override
  State<UpdateArticleUI> createState() => _UpdateArticleUIState();
}

class _UpdateArticleUIState extends State<UpdateArticleUI> {
  final UpsertArticleUIController controller =
      DiHelper.findOrCreate(creator: () => UpsertArticleUIController());
  final CategorieUIController categorieUiController =
      DiHelper.findOrCreate(creator: () => CategorieUIController());
  final PublicationTypesUIController publicationTypesUIController =
      DiHelper.findOrCreate(creator: () => PublicationTypesUIController());

  @override
  void initState() {
    super.initState();
    controller.initForUpdate();
  }

  @override
  void dispose() {
    controller.clearContent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(title: "Modifier publication"),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: controller.updateArticleFormState,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstantsUtils.scaffoldHPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MenuCard(
                      title: "Modifier une publication",
                      imagePath: "assets/images/reverend.png",
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    Obx(() {
                      if (categorieUiController.categories.value.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Catégorie",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          DropdownButtonFormField<EntityCategorie>(
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
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    Obx(() {
                      if (publicationTypesUIController
                          .publicationsTypes.value.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Type de publication",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          DropdownButtonFormField<EntityPublicationType>(
                            decoration: InputDecoration(
                                hintText: "Type de publication",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppConstantsUtils.radius),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14)),
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
                              controller.selectContentType(newValue);
                            },
                            validator: (value) => value == null
                                ? "Veuillez sélectionner un type d'article"
                                : null,
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    const Text("Titre de la publication",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.titleController,
                      hint: "Saisir le titre de la publication",
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    const Text("Description ou contenu de la publication",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.contentController,
                      hint:
                          "Saisir le contenu ou description de la publication",
                      minLines: 3,
                      maxLines: 50,
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    Obx(() {
                      final type = controller
                          .selectedContentType.value?.typePublication
                          ?.toLowerCase();

                      if (type == 'video') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Lien Youtube",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextFieldEditWidget(
                              controller: controller.urlController,
                              hint: "https://youtube.com/...",
                              keyboardType: TextInputType.url,
                              validator: (value) =>
                                  FieldFormatter.validatorUrl(value),
                            ),
                          ],
                        );
                      } else if (type == 'audio') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Fichier Audio",
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                                    const Icon(TablerIcons.paperclip),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Obx(
                                        () => Text(
                                          controller.audioFile.value?.path
                                                  .split('/')
                                                  .last ??
                                              "Sélectionnez un fichier audio (mp3, wav...)",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (type == 'article') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Rédigez votre article",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextFieldEditWidget(
                              controller: controller.textArticleController,
                              hint:
                                  "Saisir la rédaction complète de votre article",
                              minLines: 6,
                              maxLines: 200,
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    const Text("Nom & prénom de l'auteur",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFieldEditWidget(
                      controller: controller.authorController,
                      hint: "Saisir le nom & prénom de l'auteur",
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    const Text("Image de couverture",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () async {
                        await controller.pickCoverImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppConstantsUtils.radius),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            const Icon(TablerIcons.paperclip),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.coverImageFile.value?.path
                                          .split('/')
                                          .last ??
                                      "Sélectionnez un média",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async =>
                            await controller.onSubmitUpdate(),
                        child: Obx(() {
                          if (controller.isSubmitting.value) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return const Text("Mettre à jour");
                        }),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 3)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ).emptyScaffold;
  }
}