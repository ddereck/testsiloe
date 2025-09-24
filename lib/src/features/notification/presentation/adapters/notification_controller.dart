import 'package:get/get.dart';
import 'package:siloe/src/features/notification/domain/entities/entity_notification.dart';

// UseCases
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/params.dart' show NoParams;
import '../../domain/usecases/create_notification_usecase.dart'
    show CreateNotificationUseCase, CreateNotificationUseCaseParams;
import '../../domain/usecases/delete_notification_usecase.dart'
    show DeleteNotificationUseCase, DeleteNotificationUseCaseParams;
import '../../domain/usecases/get_notification_by_id_usecase.dart'
    show GetNotificationByIdUseCase, GetNotificationByIdUseCaseParams;
import '../../domain/usecases/get_notifications_usecase.dart'
    show GetNotificationsUseCase, GetNotificationsUseCaseParams;
import '../../domain/usecases/marquer_norifications_comme_lues_usecase.dart'
    show MarquerNotificationsCommeLuesUseCase;
import '../../domain/usecases/update_notification_usecase.dart'
    show UpdateNotificationUseCase, UpdateNotificationUseCaseParams;

class NotificationController extends GetxController {
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final MarquerNotificationsCommeLuesUseCase
      marquerNotificationsCommeLuesUseCase;
  final CreateNotificationUseCase createNotificationUseCase;
  final UpdateNotificationUseCase updateNotificationUseCase;
  final GetNotificationByIdUseCase getNotificationByIdUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationController({
    required this.deleteNotificationUseCase,
    required this.marquerNotificationsCommeLuesUseCase,
    required this.createNotificationUseCase,
    required this.updateNotificationUseCase,
    required this.getNotificationByIdUseCase,
    required this.getNotificationsUseCase,
  });

  Future<List<EntityNotification>> getNotifications({
    String? statut,
    bool? lu,
    int? page,
    int? perPage,
  }) async {
    try {
      final result =
          await getNotificationsUseCase.call(GetNotificationsUseCaseParams(
        statut: statut,
        lu: lu,
        page: page,
        perPage: perPage,
      ));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting notifications: ${result.$1.toString()}",
            error: result.$1);
        return [];
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting notifications: $e");
      return [];
    }
  }

  Future<EntityNotification?> getNotificationById({required int id}) async {
    try {
      final result = await getNotificationByIdUseCase.call(GetNotificationByIdUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while getting notification by id: ${result.$1.toString()}",
            error: result.$1);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting notification by id: $e");
      return null;
    }
  }

  Future<EntityNotification?> createNotification({required String titre, required String message, String? type, int? utilisateurId, Map<String, dynamic>? data,}) async {
    try {
      final result = await createNotificationUseCase.call(CreateNotificationUseCaseParams(titre: titre, message: message, type: type, utilisateurId: utilisateurId, data: data));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while creating notification: ${result.$1.toString()}",
            error: result.$1);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while creating notification: $e");
      return null;
    }
  }

  Future<EntityNotification?> updateNotification({required int id, String? titre, String? message, String? type, bool? lu, Map<String, dynamic>? data,}) async {
    try {
      final result = await updateNotificationUseCase.call(UpdateNotificationUseCaseParams(id: id, titre: titre, message: message, type: type, lu: lu, data: data));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while updating notification: ${result.$1.toString()}",
            error: result.$1);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while updating notification: $e");
      return null;
    }
  }

  Future<bool> deleteNotification({required int id}) async {
    try {
      final result = await deleteNotificationUseCase.call(DeleteNotificationUseCaseParams(id: id));
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while deleting notification: ${result.$1.toString()}",
            error: result.$1);
        return false;
      }
      return true;
    } catch (e) {
      AppLogger.instance.logger.e("Error while deleting notification: $e");
      return false;
    }
  }

  Future<bool> marquerToutesCommeLues() async {
    try {
      final result = await marquerNotificationsCommeLuesUseCase.call(NoParams());
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while marquer toutes comme lues: ${result.$1.toString()}",
            error: result.$1);
        return false;
      }
      return true;
    } catch (e) {
      AppLogger.instance.logger.e("Error while marquer toutes comme lues: $e");
      return false;
    }
  }
}
