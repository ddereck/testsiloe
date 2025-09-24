import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../commons/functions/widgets_functions.dart' show customSnackBar;
import '../../../di/controllers_provider.dart' show ControllersProvider;
import '../../../di/di_helper.dart' show DiHelper;
import '../../categorie/domain/entities/entity_categorie.dart'
    show EntityCategorie;
import '../../categorie/presentation/adapters/categorie_ui_controller.dart'
    show CategorieUIController;
import '../../evenement/domain/entities/entity_evenement.dart'
    show EntityEvenement;
import '../../evenement/presentation/data/event_datas.dart' show EventDatas;
import '../../publication_type/domain/entities/entity_publication_type.dart'
    show EntityPublicationType;
import '../../publication_type/presentation/adapters/publication_type_ui_controller.dart'
    show PublicationTypesUIController;

class UpsertEventUIController extends GetxController {
  final upsertEventFormState = GlobalKey<FormState>();

  final TextEditingController themeController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController placeCounterController = TextEditingController();
  final TextEditingController lieuController = TextEditingController();
  Rx<DateTime?> eventDateDebut = Rx<DateTime?>(null);
  Rx<DateTime?> eventDateFin = Rx<DateTime?>(null);
  Rx<TimeOfDay?> hourDate = Rx<TimeOfDay?>(null);
  Rx<EntityCategorie?> selectedCategory = Rx<EntityCategorie?>(null);
  Rx<EntityPublicationType?> selectedContentType =
      Rx<EntityPublicationType?>(null);

  final dateFormat = DateFormat('dd-MM-yyyy'); // Format JJ-MM-AA
  final timeFormat = DateFormat('HH:mm');

  void selectCategory(EntityCategorie? newCategory) {
    selectedCategory.value = newCategory;
  }

  void selectContentType(EntityPublicationType? newContentType) {
    selectedContentType.value = newContentType;
  }

  Rx<File?> currentCoverFile = Rx<File?>(null);
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      currentCoverFile.value = File(result.files.single.path!);
      update();
    }
  }

  Future<void> selectEventDate(BuildContext context,
      {bool isDebut = true}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDateDebut.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Sélectionnez une date',
    );

    if (picked != null) {
      if (isDebut) {
        eventDateDebut.value = picked;
      } else {
        eventDateFin.value = picked;
      }
      update();
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: hourDate.value ?? now,
    );
    if (picked != null) {
      hourDate.value = picked;
      update();
    }
  }

  Rx<bool> fileNotPicked = Rx<bool>(false);
  Future<void> onSubmit() async {
    // Si le fichier n´est pas sélectionner alors on ne fait rien
    if (currentCoverFile.value == null) {
      fileNotPicked.value = true;
      update();
      return;
    }

    if (!upsertEventFormState.currentState!.validate() ||
        eventDateDebut.value == null ||
        eventDateFin.value == null ||
        hourDate.value == null) {
      return;
    }
    isSubmitting.value = true;
    update();

    EntityEvenement? newValue;
    if (currentEvent.value?.id != null) {
      newValue = await ControllersProvider.EVENEMENT_CONTROLLER.updateEvenement(
        id: currentEvent.value!.id!,
        theme: themeController.text.isNotEmpty
            ? themeController.text
            : currentEvent.value?.theme,
        categorieId:
            selectedCategory.value?.id ?? currentEvent.value?.categorieId,
        typePublicationId: selectedContentType.value?.id ??
            currentEvent.value?.typePublicationId,
        texteArticle: infoController.text.isNotEmpty
            ? infoController.text
            : currentEvent.value?.texteArticle,
        dateEvenement: eventDateDebut.value?.toString() ??
            currentEvent.value?.dateEvenement,
        placesLimitees: placeCounterController.text.isNotEmpty
            ? int.tryParse(placeCounterController.text)
            : currentEvent.value?.placesLimitees,
        lieu: lieuController.text.isNotEmpty
            ? lieuController.text
            : currentEvent.value?.lieu,
        dateFin: currentEvent.value?.dateFin ?? eventDateFin.value?.toString(),
        imageDeCouverture: currentCoverFile.value,
      );
    } else {
      if (selectedCategory.value == null ||
          selectedContentType.value == null ||
          eventDateDebut.value == null) {
        isSubmitting.value = false;
        update();
        return;
      }

      newValue = await ControllersProvider.EVENEMENT_CONTROLLER.createEvenement(
        theme: themeController.text,
        categorieId: selectedCategory.value!.id!,
        typePublicationId: selectedContentType.value!.id!,
        texteArticle: infoController.text,
        dateEvenement: eventDateDebut.value!.toString(),
        dateFin: eventDateFin.value?.toString(),
        placesLimitees: placeCounterController.text.isNotEmpty
            ? int.tryParse(placeCounterController.text)
            : null,
        lieu: lieuController.text.isNotEmpty ? lieuController.text : null,
        imageDeCouverture: currentCoverFile.value,
      );
    }

    if (newValue != null) {
      customSnackBar(
          title: "Succes de l'operation",
          message: "Votre evenement a bien ete ajouté",
          isError: false);
      upsertEventFormState.currentState!.reset();
      isSubmitting.value = false;
      update();
      return;
    }

    customSnackBar(
        title: "Une error est survenue",
        message: "Une erreur est survenue, veuillez réessayer",
        isError: true);
    isSubmitting.value = false;
    update();
    return;
  }

  @override
  void onClose() {
    themeController.dispose();
    infoController.dispose();
    lieuController.dispose();
    placeCounterController.dispose();
    super.onClose();
  }

  Rx<bool> isSubmitting = Rx<bool>(false);
  Rx<EntityEvenement?> currentEvent = Rx<EntityEvenement?>(null);
  void initEventByArg() {
    currentEvent.value =
        Get.arguments?[EventDatas.evenementArg] as EntityEvenement?;
    update();
    initControllers();
  }

  void initControllers() {
    final categorieUiController =
        DiHelper.findOrCreate(creator: () => CategorieUIController());
    final publicationTypesUIController =
        DiHelper.findOrCreate(creator: () => PublicationTypesUIController());

    themeController.text = currentEvent.value?.theme ?? "";
    infoController.text = currentEvent.value?.texteArticle ?? "";
    lieuController.text = currentEvent.value?.lieu ?? "";
    placeCounterController.text =
        currentEvent.value?.placesLimitees.toString() ?? "";
    eventDateDebut.value =
        DateTime.tryParse(currentEvent.value?.dateEvenement ?? "");
    eventDateFin.value = DateTime.tryParse(currentEvent.value?.dateFin ?? "");
    hourDate.value =
        TimeOfDay.fromDateTime(eventDateDebut.value ?? DateTime.now());
    selectedCategory.value = categorieUiController
        .getCategoryById(currentEvent.value?.categorieId ?? 0);
    selectedContentType.value = publicationTypesUIController
        .getPublicationTypeById(currentEvent.value?.typePublicationId ?? 0);
    update();
  }
}
