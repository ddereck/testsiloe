import 'package:siloe/src/features/user/data/models/model_user.dart';

import '../models/model_authentication.dart';

abstract class AuthenticationDataSource {
  Future<ModelAuthentication?> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<ModelAuthentication?> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<ModelAuthentication?> signInWithGoogle();
  Future<ModelAuthentication?> signInWithApple();

  Future<void> resetPassword({required String email});

  Future<ModelUser?> signInToLaravel({String? firebaseToken});

  Future<ModelAuthentication?> logoutUser();
  Future<ModelAuthentication?> logoutUserToLaravel();
}
