import 'dart:io';

import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import 'user_data_source.dart';
import '../models/model_user.dart';

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<ModelUser?> getUserById({required int id}) async {
    try {
      final response = await ApiResources.get(ApiRoutes.utilisateurById(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelUser.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelUser?> getCurrentUser() async {
    try {
      final response = await ApiResources.get(ApiRoutes.utilisateurProfile);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelUser.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCurrentUserAccount({required int id}) async {
    try {
      final response = await ApiResources.delete(ApiRoutes.utilisateurById(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ModelUser>> getAll(
      {String? statut, String? profil, String? search}) async {
    try {
      final query = {
        if (statut != null) ApiParams.statut: statut,
        if (profil != null) ApiParams.profil: profil,
        if (search != null) ApiParams.search: search,
      };
      final response =
          await ApiResources.get(ApiRoutes.utilisateurs, query: query);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return (response.data['data'] as List)
          .map((e) => ModelUser.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelUser?> createUser({required Map<String, dynamic> data}) async {
    try {
      final response =
          await ApiResources.post(ApiRoutes.utilisateurs, data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelUser.fromJson(response.data['utilisateur']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelUser?> updateUser(int id,
      {required Map<String, dynamic> data}) async {
    try {
      final response =
          await ApiResources.put(ApiRoutes.utilisateurById(id), data: data);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }

      return ModelUser.fromJson(response.data['utilisateur']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelUser?> banUser({required int id}) async {
    try {
      final response = await ApiResources.post(ApiRoutes.utilisateurBan(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelUser.fromJson(response.data['utilisateur']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelUser?> unbanUser({required int id}) async {
    try {
      final response = await ApiResources.post(ApiRoutes.utilisateurUnban(id));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return ModelUser.fromJson(response.data['utilisateur']);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String?> updateUserPhoto({required int id, required File file}) async {
    try {
      final response = await ApiResources.post(
        ApiRoutes.utilisateurUpdatePhoto(id),
        isFormData: true,
        data: {ApiParams.photo: file},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      return response.data['photo'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
