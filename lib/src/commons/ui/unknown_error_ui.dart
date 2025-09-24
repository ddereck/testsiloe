import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../utils/text_config.dart' show TextConfig;
import '../properties/data/common_datas.dart' show CommonDatas;

class UnknownErrorUI extends StatelessWidget {

  const UnknownErrorUI({ super.key });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 50, color: Colors.red),
            const SizedBox(height: AppConstantsUtils.itemSpacing),
            Text( (Get.arguments != null && Get.arguments[CommonDatas.detailsArg] != null) ? Get.arguments[CommonDatas.detailsArg].toString() :
              "Oup´s, une erreur est survenue",
              textAlign: TextAlign.center,
              style: TextConfig.getSimpleTextStyle(true),
            ),
          ],
        ).paddingSymmetric(
          horizontal: AppConstantsUtils.scaffoldHPadding, 
          vertical: AppConstantsUtils.scaffoldVPadding,
        ),
      ),
    ).emptyScaffold;
  }
}