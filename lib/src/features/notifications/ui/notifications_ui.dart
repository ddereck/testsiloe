import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import '../../../commons/ui/widgets/empty_widget.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../di/di_helper.dart' show DiHelper;
import '../controllers/notification_ui_controller.dart';
import 'widgets/notification_item_widget.dart';

class NotificationsUI extends StatelessWidget {
  const NotificationsUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => NotificationUIController())
        ..getAllNotifications();

    return RefreshIndicator(
      onRefresh: () async => await controller.getAllNotifications(),
      child: Column(
        children: [
          TopbarWidget(title: "Notifications", trailingNotificationType: false),
          Expanded(
            child: Obx(() {
              return CustomScrollView(
                slivers: [
                  if (controller.notifications.isEmpty) ...[
                    SliverFillRemaining(
                      child: EmptyWidget(
                        title: "Aucune notification",
                        iconData: TablerIcons.lasso_polygon,
                      ).paddingSymmetric(
                          horizontal: AppConstantsUtils.scaffoldHPadding),
                    ),
                  ] else ...[
                    SliverList.builder(
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) => NotificationItemWidget(
                        notification: controller.notifications[index],
                      ).paddingOnly(
                        top: index == 0
                            ? (AppConstantsUtils.itemSpacing * 2)
                            : 0,
                        bottom: index == controller.notifications.length - 1 ? AppConstantsUtils.scaffoldWidth(context) : AppConstantsUtils.itemSpacingDualSide,
                        left: AppConstantsUtils.scaffoldHPadding,
                        right: AppConstantsUtils.scaffoldHPadding,
                      ),
                    ),
                  ],
                ],
              );
            }),
          ),
        ],
      ),
    ).emptyScaffold;
  }
}
