import 'package:get/get.dart';

import '../../../di/controllers_provider.dart' show ControllersProvider;
import '../../notification/domain/entities/entity_notification.dart' show EntityNotification;

class NotificationUIController extends GetxController {
  
  RxList<EntityNotification> notifications = RxList([]);

  Future<void> getAllNotifications() async {
    final result = await ControllersProvider.NOTIFICATION_CONTROLLER.getNotifications();
    notifications.value = result;
    update();
    return;
  }

  @override
  void onReady() async {
    super.onReady();
    await getAllNotifications();
  }

}