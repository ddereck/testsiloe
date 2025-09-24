import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../domain/entities/entity_publication_type.dart' show EntityPublicationType;

class PublicationTypesUIController extends GetxController {
  Rx<List<EntityPublicationType>> publicationsTypes = Rx<List<EntityPublicationType>>([]);
  void setPublicationTypes(List<EntityPublicationType> types) {
    publicationsTypes.value = types;
    update();
  }

  Future<void> initPublicationTypes() async {
    final result = await ControllersProvider.PUBLICATION_TYPE_CONTROLLER.getAllPublicationType();
    setPublicationTypes(result);
  }

  EntityPublicationType? getPublicationTypeById(int id) {
    return publicationsTypes.value.firstWhereOrNull((element) => element.id == id);
  }

  Rx<EntityPublicationType?> selectedType = Rx<EntityPublicationType?>(null);
  void selectType(EntityPublicationType newType) {
    selectedType.value = newType;
  }

  @override
  void onInit() async {
    super.onInit();
    await initPublicationTypes();
  }

  final isUpsertingLoading = false.obs;
  final upsertTypeFormState = GlobalKey<FormState>();
  final TextEditingController nameTypeController = TextEditingController();
  Future<void> submitNewCategory() async {
    if (!upsertTypeFormState.currentState!.validate() ||
        nameTypeController.text.isEmpty) {
      return;
    }
    isUpsertingLoading.value = true;
    update();
    final response = await ControllersProvider.PUBLICATION_TYPE_CONTROLLER
        .createPublicationType(typePublication: nameTypeController.text);
    isUpsertingLoading.value = false;
    update();
    if (response != null) {
      initPublicationTypes();
      nameTypeController.clear();
      upsertTypeFormState.currentState?.reset();
    }
  }

  @override
  void onClose() {
    nameTypeController.dispose();
    super.onClose();
  }
}