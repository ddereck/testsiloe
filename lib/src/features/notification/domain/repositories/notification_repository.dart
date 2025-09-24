import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;

/// An abstract class that represents a repository for the feature [Notification].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [NotificationRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_notification.dart';

abstract class NotificationRepository {
  Future<(Failure?, List<EntityNotification>)> getNotifications({
    String? statut,
    bool? lu,
    int? page,
    int? perPage,
  });

  Future<(Failure?, EntityNotification?)> getNotificationById(
      {required int id});

  Future<(Failure?, EntityNotification?)> createNotification({
    required String titre,
    required String message,
    String? type,
    int? utilisateurId,
    Map<String, dynamic>? data,
  });

  Future<(Failure?, EntityNotification?)> updateNotification({
    required int id,
    String? titre,
    String? message,
    String? type,
    bool? lu,
    Map<String, dynamic>? data,
  });

  Future<(Failure?, VoidType?)> deleteNotification({required int id});

  Future<(Failure?, VoidType?)> marquerToutesCommeLues();
}
