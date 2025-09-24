import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';

import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../utils/text_config.dart';

class TopbarWidget extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final bool trailingNotificationType;
  const TopbarWidget({super.key, required this.title, this.trailing, this.trailingNotificationType = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF7A0C0C),
      padding: EdgeInsets.only(top: AppConstantsUtils.statusBarHeight(context)),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(TablerIcons.chevron_left, color: Colors.white),
        ),
        title: Text(title,
            style: TextConfig.getSimpleTextStyle(true, color: Colors.white)),
        trailing: trailingNotificationType ? InkWell(
            onTap: () {
              RoutesUtils.changePage(AppRoutes.notifications);
            }, 
            child: Icon(TablerIcons.bell, color: Colors.white)) : trailing,
      ),
    );
  }
}
