// widgets/scrollable_menu.dart
import 'package:flutter/material.dart';

import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../utils/text_config.dart' show TextConfig;

class ScrollableMenu extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const ScrollableMenu({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          spacing: AppConstantsUtils.itemSpacingDualSide,
          children: List.generate(categories.length, (index) {
            final category = categories[index];
            final isSelected = category == selectedCategory;

            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstantsUtils.buttonHPadding,
                  vertical: AppConstantsUtils.buttonVPadding,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
                ),
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: TextConfig.getSimpleTextStyle(
                    true,
                    size: AppConstantsUtils.tinySize,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
