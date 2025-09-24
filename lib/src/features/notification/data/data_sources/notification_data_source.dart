import '../models/model_notification.dart';

abstract class NotificationDataSource {

  Future<List<ModelNotification>> getNotifications({
    String? statut,
    bool? lu,
    int? page,
    int? perPage,
  });

  Future<ModelNotification> getNotificationById({required int id});

  Future<ModelNotification> createNotification({
    required String titre,
    required String message,
    String? type,
    int? utilisateurId,
    Map<String, dynamic>? data,
  });

  Future<ModelNotification> updateNotification({
    required int id,
    String? titre,
    String? message,
    String? type,
    bool? lu,
    Map<String, dynamic>? data,
  });

  Future<void> deleteNotification({required int id});

  Future<void> marquerToutesCommeLues();

}
