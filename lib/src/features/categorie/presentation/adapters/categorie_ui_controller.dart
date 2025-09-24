import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../di/controllers_provider.dart' show ControllersProvider;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../publication/presentation/adapters/publication_ui_controller.dart' show PublicationsUIController;
import '../../domain/entities/entity_categorie.dart' show EntityCategorie;

class CategorieUIController extends GetxController {

  EntityCategorie allCaterogie = EntityCategorie(id: 0, nomCategorie: "Tout");
  //
  Rx<List<EntityCategorie>> categories = Rx<List<EntityCategorie>>([]);
  void initCategories() async {
    final result =
        await ControllersProvider.CATEGORIE_CONTROLLER.getAllCategories();

    categories.value = [allCaterogie, ...result];
    update();
  }

  EntityCategorie? getCategoryById(int id) {
    return categories.value.firstWhereOrNull((element) => element.id == id);
  }

  Rx<EntityCategorie?> selectedCategory = Rx<EntityCategorie?>(null);
  void selectCategory(EntityCategorie category) {
    selectedCategory.value = category;
    final publicationsUiController =
        DiHelper.findOrCreate(creator: () => PublicationsUIController());
    publicationsUiController.updateFilteredPublicationByCategory(category);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    selectedCategory.value = allCaterogie;
    categories.value.add(allCaterogie);
  }

  final isUpsertingLoading = false.obs;
  final upsertCategoryFormState = GlobalKey<FormState>();
  final TextEditingController nameCategoryController = TextEditingController();
  Future<void> submitNewCategory() async {
    if (!upsertCategoryFormState.currentState!.validate() ||
        nameCategoryController.text.isEmpty) {
      return;
    }
    isUpsertingLoading.value = true;
    update();
    final response = await ControllersProvider.CATEGORIE_CONTROLLER
        .createCategorie(nomCategorie: nameCategoryController.text);
    isUpsertingLoading.value = false;
    update();
    if (response != null) {
      initCategories();
      nameCategoryController.clear();
      upsertCategoryFormState.currentState?.reset();
    }
  }

  @override
  void onClose() {
    nameCategoryController.dispose();
    super.onClose();
  }
}
