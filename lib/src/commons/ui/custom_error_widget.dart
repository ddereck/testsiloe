import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import '../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../utils/text_config.dart' show TextConfig;


class CustomErrorUI extends StatelessWidget {

  final FlutterErrorDetails details;
  const CustomErrorUI({ super.key, required this.details });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:kDebugMode ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 50, color: Colors.red),
            const SizedBox(height: AppConstantsUtils.itemSpacing),
            Text( kDebugMode ? details.stack.toString() : 
              "Oup´s, une erreur est survenue",
              textAlign: kDebugMode ? TextAlign.start : TextAlign.center,
              style: TextConfig.getSimpleTextStyle(true, size: 10),
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