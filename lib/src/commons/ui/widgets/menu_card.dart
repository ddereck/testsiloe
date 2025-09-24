import 'package:flutter/material.dart';

import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;

class MenuCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final IconData? icon;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: SizedBox(
          height: 100,
          child: Row(
            spacing: AppConstantsUtils.itemSpacing,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if(icon != null) ...[
                Icon(icon),
              ],
              const SizedBox(width: AppConstantsUtils.itemSpacing),
            ],
          ),
        ),
      ),
    );
  }
}