import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../commons/functions/widgets_functions.dart' show customSnackBar;
import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../domain/entities/entity_evenement.dart'
    show EntityEvenement;
import '../data/event_datas.dart' show EventDatas;

class UpsertEventUIController extends GetxController {
  final upsertEventFormState = GlobalKey<FormState>();

  final TextEditingController titreController = TextEditingController();
  final TextEditingController sousTitreController = TextEditingController();
  final TextEditingController textePublicationController =
      TextEditingController();

  Rx<File?> currentCoverFile = Rx<File?>(null);
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      currentCoverFile.value = File(result.files.single.path!);
      update();
    }
  }

  Future<void> onSubmit() async {
    if (!upsertEventFormState.currentState!.validate()) {
      return;
    }

    if (currentEvent.value == null && currentCoverFile.value == null) {
      customSnackBar(
        title: "Erreur",
        message: "Veuillez sélectionner une image de couverture.",
        isError: true,
      );
      return;
    }

    isSubmitting.value = true;
    update();

    EntityEvenement? newValue;
    // The API seems to require these fields, so we send default values.
    // In a real application, these would either be part of the form
    // or handled differently based on business logic.
    final eventData = {
      'theme': titreController.text,
      'sousTitre': sousTitreController.text,
      'texteArticle': textePublicationController.text,
      'imageDeCouverture': currentCoverFile.value,
      'categorieId': 1,
      'typePublicationId': 1,
      'dateEvenement': DateTime.now().toIso8601String(),
    };

    if (currentEvent.value?.id != null) {
      newValue = await ControllersProvider.EVENEMENT_CONTROLLER.updateEvenement(
        id: currentEvent.value!.id!,
        ...eventData,
      );
    } else {
      newValue =
          await ControllersProvider.EVENEMENT_CONTROLLER.createEvenement(
        ...eventData,
      );
    }

    isSubmitting.value = false;
    update();

    if (newValue != null) {
      customSnackBar(
        title: "Succès",
        message: "L'événement a été sauvegardé avec succès.",
        isError: false,
      );
      Get.back();
    } else {
      customSnackBar(
        title: "Erreur",
        message: "Une erreur est survenue. Veuillez réessayer.",
        isError: true,
      );
    }
  }

  @override
  void onClose() {
    titreController.dispose();
    sousTitreController.dispose();
    textePublicationController.dispose();
    super.onClose();
  }

  Rx<bool> isSubmitting = Rx<bool>(false);
  Rx<EntityEvenement?> currentEvent = Rx<EntityEvenement?>(null);

  @override
  void onInit() {
    super.onInit();
    initEventByArg();
  }

  void initEventByArg() {
    final event = Get.arguments?[EventDatas.evenementArg] as EntityEvenement?;
    if (event != null) {
      currentEvent.value = event;
      titreController.text = event.theme ?? '';
      sousTitreController.text = event.sousTitre ?? '';
      textePublicationController.text = event.texteArticle ?? '';
    }
    update();
  }
}