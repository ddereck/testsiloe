import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/configs/time_config.dart' show TimeConfig;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../utils/text_config.dart' show TextConfig;
import '../../../notification/domain/entities/entity_notification.dart' show EntityNotification;

class NotificationItemWidget extends StatelessWidget {
  final EntityNotification notification;
  const NotificationItemWidget({ super.key, required this.notification });

  @override
  Widget build(BuildContext context) {
    if(notification.titre == null && notification.message == null) return const SizedBox.shrink();
    return InkWell(
      onTap: () async {
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstantsUtils.containerHPadding, vertical: AppConstantsUtils.containerVPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
          color: Theme.of(context).highlightColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(
              child: Icon(TablerIcons.lasso_polygon),
            ),
            const SizedBox(width: AppConstantsUtils.itemSpacing),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(notification.titre != null) ...[
                    Text(notification.titre ?? "",
                      style: TextConfig.getSimpleTextStyle(true),
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                  ],
                  if(notification.message != null) ...[
                    Text(notification.message  ?? "",
                      style: TextConfig.getSimpleTextStyle(true),
                    ),
                  ],
                  if(notification.envoyeAt != null) ...[
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    Text(TimeConfig.parseAnyDateFormatted(notification.envoyeAt),
                      overflow: TextOverflow.ellipsis,
                      style: TextConfig.getSimpleTextStyle(true, size: 10),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}