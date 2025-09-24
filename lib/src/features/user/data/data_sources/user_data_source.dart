import 'dart:io';

import '../models/model_user.dart';

abstract class UserDataSource {

  Future<ModelUser?> getUserById({ required int id });
  Future<ModelUser?> getCurrentUser();
  Future<void> deleteCurrentUserAccount({ required int id });
  Future<List<ModelUser>> getAll({String? statut, String? profil, String? search});
  Future<ModelUser?> createUser({required Map<String, dynamic> data});
  Future<ModelUser?> updateUser(int id, {required Map<String, dynamic> data});
  Future<String?> updateUserPhoto({required int id, required File file});
  Future<ModelUser?> banUser({required int id});
  Future<ModelUser?> unbanUser({required int id});
}
