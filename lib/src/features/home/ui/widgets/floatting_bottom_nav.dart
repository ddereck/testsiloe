import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:siloe/src/commons/extensions/glass_effect_extension.dart';
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;

class FloatingBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const FloatingBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<IconData> _icons = const [
    TablerIcons.smart_home,
    Icons.timelapse_rounded,
  ];

  final List<String> _labels = const [
    "Accueil",
    "Siloé",
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Container(
          height: 60,
          width: double.infinity,
          /*
          padding: EdgeInsets.only(
            top: AppConstantsUtils.itemSpacing,
            bottom: bottomPadding + AppConstantsUtils.itemSpacing,
          ),
           */
          margin: EdgeInsets.symmetric(
            horizontal: AppConstantsUtils.scaffoldWidth(context) * 0.20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstantsUtils.radiusLarge * 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 0,
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_icons.length, (index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () => onItemTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: isSelected
                          ? AppConstantsUtils.iconSizeLargeSelected
                          : AppConstantsUtils.iconSizeMiddleSelected,
                      height: isSelected
                          ? AppConstantsUtils.iconSizeLargeSelected
                          : AppConstantsUtils.iconSizeMiddleSelected,
                      child: Icon(
                        _icons[index],
                        size: isSelected
                            ? AppConstantsUtils.iconSizeLargeSelected
                            : AppConstantsUtils.iconSizeMiddleSelected,
                        color: isSelected ? Colors.red.shade900 : Colors.black,
                      ),
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacingSmall),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isSelected
                          ? Container(
                        key: ValueKey('bar_$index'),
                        height: 5,
                        width: AppConstantsUtils.iconSizeMedium,
                        decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                          : Text(
                        _labels[index],
                        key: ValueKey('text_$index'),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ).withGlassEffect(
            blur: 15,
            opacity: 0.5,
            borderRadius: BorderRadius.circular(AppConstantsUtils.radiusLarge * 2.5),
          ),
        ),
      ),
    );
  }
}
