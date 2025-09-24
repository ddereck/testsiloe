import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../commons/ui/widgets/scrollable_menu.dart' show ScrollableMenu;
import '../../../../../di/di_helper.dart' show DiHelper;
import '../../adapters/categorie_ui_controller.dart' show CategorieUIController;

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categorieUiController =
        DiHelper.findOrCreate(creator: () => CategorieUIController())
          ..initCategories();
    return Obx(() {
      if(categorieUiController.categories.value.isEmpty) {
        return const SizedBox.shrink();
      }
      List<String> categories = categorieUiController.categories.value.where((e) => e.nomCategorie != null).map((e) => e.nomCategorie!).toList();
      return ScrollableMenu(
        categories: categories,
        selectedCategory: categorieUiController.selectedCategory.value?.nomCategorie ?? categories.first,
        onCategorySelected: (value) {
          categorieUiController.selectCategory(categorieUiController.categories.value.firstWhere((e) => e.nomCategorie == value));
        },
      );
    });
  }
}
