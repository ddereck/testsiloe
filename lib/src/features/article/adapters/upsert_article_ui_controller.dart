import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/features/publication/domain/entities/entity_publication.dart';

import '../../../commons/functions/widgets_functions.dart' show customSnackBar;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../di/controllers_provider.dart' show ControllersProvider;
import '../../categorie/domain/entities/entity_categorie.dart'
    show EntityCategorie;
import '../../publication_type/domain/entities/entity_publication_type.dart'
    show EntityPublicationType;
import '../../publication_type/presentation/adapters/publication_type_ui_controller.dart'
    show PublicationTypesUIController;
import 'article_datas.dart' show ArticleDatas;

class UpsertArticleUIController extends GetxController {
  final addArticleFormState = GlobalKey<FormState>();
  final updateArticleFormState = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController textArticleController = TextEditingController();
  Rx<EntityCategorie?> selectedCategory = Rx<EntityCategorie?>(null);
  Rx<EntityPublicationType?> selectedContentType =
      Rx<EntityPublicationType?>(null);
  Rx<EntityPublication?> article = Rx<EntityPublication?>(null);

  void selectCategory(EntityCategorie? newCategory) {
    selectedCategory.value = newCategory;
  }

  void selectContentType(EntityPublicationType? newContentType) {
    selectedContentType.value = newContentType;
  }

  // Image de couverture
  Rx<File?> coverImageFile = Rx<File?>(null);
  // Fichier audio
  Rx<File?> audioFile = Rx<File?>(null);

  Rx<bool> isSubmitting = Rx<bool>(false);
  Rx<bool> fileNotPicked = Rx<bool>(false);


  /// Prépare le contrôleur pour une création (formulaire vierge)
  void prepareForCreate() {
    article.value = null;
    clearContent();
    fileNotPicked.value = false;
    selectedCategory.value = null;
    selectedContentType.value = null;
    update();
  }

  Future<void> pickCoverImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
    );
    if (result != null && result.files.single.path != null) {
      coverImageFile.value = File(result.files.single.path!);
      fileNotPicked.value = false;
      update();
    }
  }

  Future<void> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'aac', 'wav', 'm4a', 'ogg'],
    );
    if (result != null && result.files.single.path != null) {
      audioFile.value = File(result.files.single.path!);
      fileNotPicked.value = false;
      update();
    }
  }

  Future<void> onSubmit() async {
    if (coverImageFile.value == null) {
      fileNotPicked.value = true;
      update();
      return;
    }

    if (audioFile.value == null) {
      fileNotPicked.value = true;
      update();
      return;
    }

    if (!addArticleFormState.currentState!.validate() ||
        selectedCategory.value == null ||
        selectedContentType.value == null) {
      return;
    }

    isSubmitting.value = true;
    update();

    try {
      final response =
          await ControllersProvider.PUBLICATION_CONTROLLER.createPublication(
        titre: titleController.text,
        description: contentController.text,
        url: urlController.text.isEmpty ? null : urlController.text,
        datePublication: DateTime.now().toIso8601String(),
        auteur: authorController.text,
        categorieId: selectedCategory.value!.id!,
        typePublicationId: selectedContentType.value!.id!,
        img: coverImageFile.value,
        file: audioFile.value,
        textArticle: textArticleController.text,
      );

      isSubmitting.value = false;
      update();

      if (response != null) {
        customSnackBar(
          title: "Publication",
          message: "Votre article a bien été publié ✅",
          isError: false,
        );
        addArticleFormState.currentState?.reset();
        clearContent();

        // Rediriger vers les détails de l'article créé
        if (response.id != null) {
          Get.back(); // Fermer la page de création

          // Récupérer l'article complet depuis l'API
          try {
            final articleDetails = await ControllersProvider
                .PUBLICATION_CONTROLLER
                .getPublicationById(id: response.id!);

            if (articleDetails != null) {
              // Naviguer vers les détails avec l'article complet
              RoutesUtils.changePage(AppRoutes.articleDetails,
                  arguments: {'articleArg': articleDetails});
              print(
                  'DEBUG - Navigation vers les détails de l\'article ID: ${response.id}');
            } else {
              print(
                  'DEBUG - Impossible de récupérer les détails de l\'article ID: ${response.id}');
            }
          } catch (e) {
            print('DEBUG - Erreur lors de la récupération des détails: $e');
          }
        }
      } else {
        customSnackBar(
          title: "Erreur",
          message: "La publication a échoué ❌",
          isError: true,
        );
      }
    } catch (e) {
      isSubmitting.value = false;
      update();
      customSnackBar(
        title: "Erreur",
        message: "⛔ ${e.toString()}",
        isError: true,
      );
    }
  }

  Future<void> onSubmitUpdate() async {
    if (article.value?.id == null) {
      customSnackBar(
        title: "Erreur",
        message: "Aucun article à mettre à jour",
        isError: true,
      );
      return;
    }

    if (!updateArticleFormState.currentState!.validate() ||
        selectedCategory.value == null ||
        selectedContentType.value == null) {
      return;
    }

    isSubmitting.value = true;
    update();

    try {
      final response =
          await ControllersProvider.PUBLICATION_CONTROLLER.updatePublication(
        id: article.value!.id!,
        titre: titleController.text,
        description: contentController.text,
        url: urlController.text.isEmpty ? null : urlController.text,
        datePublication: DateTime.now().toIso8601String(),
        auteur: authorController.text,
        categorieId: selectedCategory.value!.id!,
        typePublicationId: selectedContentType.value!.id!,
        img: coverImageFile.value,
        file: audioFile.value,
        textArticle: textArticleController.text,
      );

      isSubmitting.value = false;
      update();

      if (response != null) {
        // Mettre à jour l'article local avec les nouvelles données
        article.value = response;
        update();

        customSnackBar(
          title: "Mise à jour",
          message: "Publication mise à jour avec succès ✅",
          isError: false,
        );

        Get.back(); // Fermer la page de mise à jour
        RoutesUtils.changePage(AppRoutes.home);
      } else {
        customSnackBar(
          title: "Erreur",
          message: "La mise à jour a échoué ❌",
          isError: true,
        );
      }
    } catch (e) {
      isSubmitting.value = false;
      update();
      customSnackBar(
        title: "Erreur",
        message: "⛔ ${e.toString()}",
        isError: true,
      );
    }
  }

  void initPublication() {
    article.value =
        Get.arguments?[ArticleDatas.articleArg] as EntityPublication?;
    update();
  }

  void initControllers(PublicationTypesUIController publicationTypesUIController) {
    titleController.text = article.value?.titre ?? '';
    contentController.text = article.value?.description ?? '';
    urlController.text = article.value?.url ?? '';
    authorController.text = article.value?.auteur ?? '';
    textArticleController.text = article.value?.article ?? '';

    if (article.value?.typePublicationId != null) {
      final typeId = article.value!.typePublicationId!;
     final type = publicationTypesUIController.publicationsTypes.value
    .firstWhereOrNull((e) => e.id == typeId);

      selectedContentType.value = type;
    }

    // Image de couverture
    if (article.value?.img != null) {
      //coverImageFile.value = null;
    }

    // Fichier audio
    if (article.value?.file != null) {
      //audioFile.value = null;
    }
    update();
  }

  void iniCategoryController(List<EntityCategorie> categories) {
    selectedCategory.value = categories
        .where((element) => element.id == article.value?.categorieId)
        .firstOrNull;
    update();
  }

  void iniContentTypeController(List<EntityPublicationType> types) {
    selectedContentType.value = types
        .where((element) => element.id == article.value?.typePublicationId)
        .firstOrNull;
    update();
  }

  void clearContent() {
    titleController.clear();
    contentController.clear();
    urlController.clear();
    authorController.clear();
    textArticleController.clear();
    selectedCategory.value = null;
    selectedContentType.value = null;
    coverImageFile.value = null;
    audioFile.value = null;
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    urlController.dispose();
    authorController.dispose();
    textArticleController.dispose();
    super.onClose();
  }
}
