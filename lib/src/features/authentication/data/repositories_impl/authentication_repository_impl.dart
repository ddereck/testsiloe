import 'package:siloe/src/core/resources/params.dart';
import 'package:siloe/src/features/user/domain/entities/entity_user.dart';

import '../../../../core/errors/failure.dart';

import '../../domain/entities/entity_authentication.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../data_sources/authentication_data_source.dart';

/// A class that implements [AuthenticationRepository].
///
/// The class is named [AuthenticationRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource dataSource;
  const AuthenticationRepositoryImpl(this.dataSource);

  /// Implements [AuthenticationRepository.signInWithEmailAndPassword].
  ///
  /// The method calls [AuthenticationDataSource.signInWithEmailAndPassword]
  /// and returns the result as a tuple of [Failure] and [EntityAuthentication].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityAuthentication?)> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await dataSource.signInWithEmailAndPassword(
          email: email, password: password);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.signUpWithEmailAndPassword].
  ///
  /// The method calls [AuthenticationDataSource.signUpWithEmailAndPassword]
  /// and returns the result as a tuple of [Failure] and [EntityAuthentication].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityAuthentication?)> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await dataSource.signUpWithEmailAndPassword(
          email: email, password: password);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.signInWithGoogle].
  @override
  Future<(Failure?, EntityAuthentication?)> signInWithGoogle() async {
    try {
      final result = await dataSource.signInWithGoogle();
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityAuthentication?)> signInWithApple() async {
    try {
      final result = await dataSource.signInWithApple();
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.logoutUser].
  ///
  /// The method calls [AuthenticationDataSource.logoutUser]
  /// and returns the result as a tuple of [Failure] and [EntityAuthentication].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityAuthentication?)> logoutUser() async {
    try {
      final result = await dataSource.logoutUser();
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.signInToLaravel].
  ///
  /// The method calls [AuthenticationDataSource.signInToLaravel]
  /// and returns the result as a tuple of [Failure] and [EntityUser].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityUser?)> signInToLaravel(
      {String? firebaseToken}) async {
    try {
      final result =
          await dataSource.signInToLaravel(firebaseToken: firebaseToken);
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.logoutUserToLaravel].
  ///
  /// The method calls [AuthenticationDataSource.logoutUserToLaravel]
  /// and returns the result as a tuple of [Failure] and [EntityAuthentication].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, EntityAuthentication?)> logoutUserToLaravel() async {
    try {
      final result = await dataSource.logoutUserToLaravel();
      return (null, result?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  /// Implements [AuthenticationRepository.resetPassword].
  ///
  /// The method calls [AuthenticationDataSource.resetPassword]
  /// and returns the result as a tuple of [Failure] and [VoidType].
  ///
  /// The method is marked as [override] and should be implemented by the user.
  @override
  Future<(Failure?, VoidType?)> resetPassword({required String email}) async {
    try {
      await dataSource.resetPassword(email: email);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }
}
