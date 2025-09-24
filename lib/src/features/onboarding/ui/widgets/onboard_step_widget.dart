import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../utils/text_config.dart' show TextConfig;

class OnboardStepWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? imageSrc;
  const OnboardStepWidget({ super.key, required this.title, required this.description, this.imageSrc });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          if(imageSrc != null) ...[

          ],
          const SizedBox(height:  AppConstantsUtils.itemSpacing * 2),
          Text(title,
            textAlign: TextAlign.center,
            style: TextConfig.getSimpleTextStyle(true,
              size: AppConstantsUtils.hightTitleSize,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: AppConstantsUtils.itemSpacing),
          Text(description,
            textAlign: TextAlign.center,
            style: TextConfig.getSimpleTextStyle(true,
              size: AppConstantsUtils.titleSize,
            ),
          ),
          const Spacer(),
        ],
      ).paddingSymmetric(horizontal: AppConstantsUtils.scaffoldHPadding),
    );
  }
}