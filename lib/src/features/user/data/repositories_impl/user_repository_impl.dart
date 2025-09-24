import 'dart:io';

import '../../../../core/errors/failure.dart';


import '../../../../core/resources/params.dart' show VoidType;
import '../../domain/entities/entity_user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_data_source.dart';

/// A class that implements [UserRepository].
///
/// The class is named [UserRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class UserRepositoryImpl implements UserRepository {

  final UserDataSource dataSource;
  const UserRepositoryImpl(this.dataSource);

  /// Implements [UserRepository.getUserById].
  ///
  /// The method calls [UserDataSource.getUserById]
  /// and returns the result as a tuple of [Failure] and [EntityUser].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityUser?)> getUserById({ required int id }) async {
    try {
      final result = await dataSource.getUserById(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [UserRepository.banUser].
  ///
  /// The method calls [UserDataSource.banUser]
  /// and returns the result as a tuple of [Failure] and [EntityUser].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityUser?)> banUser({ required int id }) async {
    try {
      final result = await dataSource.banUser(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [UserRepository.unbanUser].
  ///
  /// The method calls [UserDataSource.unbanUser]
  /// and returns the result as a tuple of [Failure] and [EntityUser].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityUser?)> unbanUser({ required int id }) async {
    try {
      final result = await dataSource.unbanUser(id: id);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [UserRepository.updateUserPhoto].
  ///
  /// The method calls [UserDataSource.updateUserPhoto]
  /// and returns the result as a tuple of [Failure] and [EntityUser].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, String?)> updateUserPhoto({required int id, required File file}) async {
    try {
      final result = await dataSource.updateUserPhoto(id: id, file: file);
      return (null, result);
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [UserRepository.getCurrentUser].
  ///
  /// The method calls [UserDataSource.getCurrentUser]
  /// and returns the result as a tuple of [Failure] and [EntityUser].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityUser?)> getCurrentUser() async {
    try {
      final result = await dataSource.getCurrentUser();
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [UserRepository.deleteCurrentUserAccount].
  ///
  /// The method calls [UserDataSource.deleteCurrentUserAccount]
  /// and returns the result as a tuple of [Failure] and [EntityUser].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, VoidType?)> deleteCurrentUserAccount({ required int id }) async {
    try {
      await dataSource.deleteCurrentUserAccount(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, EntityUser?)> createUser({required Map<String, dynamic> data}) async {
    try {
      final result = await dataSource.createUser(data: data);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, List<EntityUser>)> getAll({String? statut, String? profil, String? search}) async {
    try {
      final result = await dataSource.getAll(statut: statut, profil: profil, search: search);
      return (null, result.map((e) => e.toEntity()).toList());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<(Failure?, EntityUser?)> updateUser(int id, {required Map<String, dynamic> data}) async {
    try {
      final result = await dataSource.updateUser(id, data: data);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }


}
