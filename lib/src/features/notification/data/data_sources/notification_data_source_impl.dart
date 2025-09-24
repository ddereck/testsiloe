import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'notification_data_source.dart';
import '../models/model_notification.dart';

class NotificationDataSourceImpl implements NotificationDataSource {
  final FirebaseAuth firebaseAuth;

  const NotificationDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelNotification> createNotification({
    required String titre,
    required String message,
    String? type,
    int? utilisateurId,
    Map<String, dynamic>? data,
  }) async {
    try {
      final body = {
        ApiParams.titre: titre,
        ApiParams.message: message,
        if (type != null) ApiParams.type: type,
        if (utilisateurId != null) ApiParams.utilisateurId: utilisateurId,
        if (data != null) ApiParams.data: data,
      };

      final response =
          await ApiResources.post(ApiRoutes.notifications, data: body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelNotification.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteNotification({required int id}) async {
    try {
      final response =
          await ApiResources.delete(ApiRoutes.notificationById(id));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelNotification> getNotificationById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.notificationById(id));

      if (response.statusCode != 200) {
        throw Exception(response.data);
      }

      return ModelNotification.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelNotification>> getNotifications({
    String? statut,
    bool? lu,
    int? page,
    int? perPage,
  }) async {
    try {
      final query = {
        if (statut != null) ApiParams.statut: statut,
        if (lu != null) ApiParams.lu: lu.toString(),
        if (page != null) ApiParams.page: page.toString(),
        if (perPage != null) ApiParams.perPage: perPage.toString(),
      };

      final response =
          await ApiResources.get(ApiRoutes.notifications, query: query);

      if (response.statusCode != 200) {
        throw Exception(response.data);
      }

      final data = response.data['data'] ?? [];

      return (data as List).map((e) => ModelNotification.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> marquerToutesCommeLues() async {
    try {
      final response =
          await ApiResources.post(ApiRoutes.marquerToutesNotifsLues);

      if (response.statusCode != 200) {
        throw Exception(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelNotification> updateNotification({
    required int id,
    String? titre,
    String? message,
    String? type,
    bool? lu,
    Map<String, dynamic>? data,
  }) async {
    try {
      final body = {
        if (titre != null) ApiParams.titre: titre,
        if (message != null) ApiParams.message: message,
        if (type != null) ApiParams.type: type,
        if (lu != null) ApiParams.lu: lu,
        if (data != null) ApiParams.data: data,
      };

      final response =
          await ApiResources.put(ApiRoutes.notificationById(id), data: body);

      if (response.statusCode != 200) {
        throw Exception(response.data);
      }

      return ModelNotification.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
