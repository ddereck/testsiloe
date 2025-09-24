import 'dart:io';

import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [User].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [UserRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_user.dart';

abstract class UserRepository {

  Future<(Failure?, EntityUser?)> getUserById({ required int id });
  Future<(Failure?, EntityUser?)> getCurrentUser();
  Future<(Failure?, VoidType?)> deleteCurrentUserAccount({ required int id });
  Future<(Failure?, List<EntityUser>)> getAll({String? statut, String? profil, String? search});
  Future<(Failure?, EntityUser?)> createUser({required Map<String, dynamic> data});
  Future<(Failure?, EntityUser?)> updateUser(int id, {required Map<String, dynamic> data});
  Future<(Failure?, String?)> updateUserPhoto({required int id, required File file});
  Future<(Failure?, EntityUser?)> banUser({required int id});
  Future<(Failure?, EntityUser?)> unbanUser({required int id});

}
