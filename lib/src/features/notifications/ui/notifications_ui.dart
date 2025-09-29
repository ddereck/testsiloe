import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/features/user/domain/enums/user_role_enums.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../notification/domain/entities/entity_notification.dart';
import 'widgets/notification_item_widget.dart';

class NotificationsUI extends StatelessWidget {
  const NotificationsUI({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ControllersProvider.USER_CONTROLLER.user.value;
    final isReverend =
        user?.roles.any((role) => role.toUserRole() == UserRoleEnums.reverend) ??
            false;

    // Static data for demonstration purposes
    final List<EntityNotification> notifications = [
      EntityNotification(
        titre: isReverend
            ? 'Nouvelle demande de rencontre'
            : 'Votre demande de rencontre a été acceptée',
        message: isReverend
            ? 'De: Jean Dupont'
            : 'Votre rencontre avec le Révérend est confirmée pour le 25/12/2025.',
        envoyeAt: DateTime.now().subtract(const Duration(hours: 1)).toString(),
      ),
      EntityNotification(
        titre: isReverend
            ? 'Nouvelle requête de prière'
            : 'Confirmation de votre don',
        message: isReverend
            ? 'Une nouvelle requête de prière a été soumise.'
            : 'Votre don de 50€ a bien été reçu. Merci pour votre soutien.',
        envoyeAt: DateTime.now().subtract(const Duration(days: 1)).toString(),
      ),
      EntityNotification(
        titre: 'Mise à jour de l\'application',
        message:
            'Une nouvelle version de l\'application est disponible. Mettez à jour maintenant pour profiter des dernières fonctionnalités.',
        envoyeAt: DateTime.now().subtract(const Duration(days: 3)).toString(),
      ),
    ];

    return Column(
      children: [
        TopbarWidget(title: "Notifications"),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationItemWidget(
                notification: notifications[index],
                isRead: index > 0, // Mark first as unread, others as read
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: 12),
          ),
        ),
      ],
    ).simpleScaffold;
  }
}