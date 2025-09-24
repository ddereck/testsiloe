import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';


import '../../domain/entities/entity_notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../data_sources/notification_data_source.dart';

/// A class that implements [NotificationRepository].
///
/// The class is named [NotificationRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class NotificationRepositoryImpl implements NotificationRepository {

  final NotificationDataSource dataSource;
  const NotificationRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, EntityNotification?)> createNotification({required String titre, required String message, 
  String? type, int? utilisateurId, Map<String, dynamic>? data,}) async {
    try {
      final result = await dataSource.createNotification(titre: titre, message: message, type: type, utilisateurId: utilisateurId, data: data);
      return (null, result.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deleteNotification({required int id}) async {
    try {
      await dataSource.deleteNotification(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityNotification?)> getNotificationById({required int id}) async {
    try {
      final result = await dataSource.getNotificationById(id: id);
      return (null, result.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityNotification>)> getNotifications({String? statut, bool? lu, int? page, int? perPage,}) async {
    try {
      final result = await dataSource.getNotifications(statut: statut, lu: lu, page: page, perPage: perPage);
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> marquerToutesCommeLues() async {
    try {
      await dataSource.marquerToutesCommeLues();
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityNotification?)> updateNotification({required int id, String? titre, String? message, String? type, 
    bool? lu, Map<String, dynamic>? data,}) async {
    try {
      final result = await dataSource.updateNotification(id: id, titre: titre, message: message, type: type, lu: lu, data: data);
      return (null, result.toEntity());
    } catch (e) {
      rethrow;
    }
  }



}
