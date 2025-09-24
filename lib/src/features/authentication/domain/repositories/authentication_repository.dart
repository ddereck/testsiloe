import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
import '../../../user/domain/entities/entity_user.dart' show EntityUser;

/// An abstract class that represents a repository for the feature [Authentication].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [AuthenticationRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_authentication.dart';

abstract class AuthenticationRepository {
  Future<(Failure?, EntityAuthentication?)> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<(Failure?, EntityAuthentication?)> signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<(Failure?, EntityAuthentication?)> signInWithGoogle();
  Future<(Failure?, EntityAuthentication?)> signInWithApple();
  Future<(Failure?, VoidType?)> resetPassword({required String email});
  Future<(Failure?, EntityUser?)> signInToLaravel({String? firebaseToken});
  Future<(Failure?, EntityAuthentication?)> logoutUser();
  Future<(Failure?, EntityAuthentication?)> logoutUserToLaravel();
}
