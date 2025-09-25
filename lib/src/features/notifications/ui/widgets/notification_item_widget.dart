import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/configs/time_config.dart' show TimeConfig;
import '../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../utils/text_config.dart' show TextConfig;
import '../../../notification/domain/entities/entity_notification.dart'
    show EntityNotification;

class NotificationItemWidget extends StatelessWidget {
  final EntityNotification notification;
  final bool isRead;

  const NotificationItemWidget({
    super.key,
    required this.notification,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    if (notification.titre == null && notification.message == null) {
      return const SizedBox.shrink();
    }
    return InkWell(
      onTap: () async {
        // In a real app, this would mark the notification as read.
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstantsUtils.containerHPadding,
          vertical: AppConstantsUtils.containerVPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
          color: isRead ? Colors.grey[200] : Colors.white,
          boxShadow: [
            if (!isRead)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(TablerIcons.bell_ringing, color: Color(0xFF7A0C0C)),
            ),
            const SizedBox(width: AppConstantsUtils.itemSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notification.titre != null) ...[
                    Text(
                      notification.titre!,
                      style: TextConfig.getSimpleTextStyle(true,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                  ],
                  if (notification.message != null) ...[
                    Text(
                      notification.message!,
                      style: TextConfig.getSimpleTextStyle(
                          false,
                          color: Colors.grey[800]),
                    ),
                  ],
                  if (notification.envoyeAt != null) ...[
                    const SizedBox(height: AppConstantsUtils.itemSpacing),
                    Text(
                      TimeConfig.parseAnyDateFormatted(notification.envoyeAt),
                      overflow: TextOverflow.ellipsis,
                      style: TextConfig.getSimpleTextStyle(true,
                          size: 10, color: Colors.grey[600]),
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