import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../core/api/api_params.dart' show ApiParams;
import '../../../../core/api/api_resources.dart' show ApiResources;
import '../../../../core/api/api_routes.dart' show ApiRoutes;
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/database_attributes_resources.dart'
    show DatabaseAttributesResources;
import '../../../user/data/models/model_user.dart' show ModelUser;
import 'authentication_data_source.dart';
import '../models/model_authentication.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationDataSourceImpl(this.firebaseAuth);

  @override
  Future<ModelUser?> signInToLaravel({String? firebaseToken}) async {
    try {
      final newToken = await firebaseAuth.currentUser?.getIdToken(false);
      AppLogger.instance.logger.i("User => ${firebaseAuth.currentUser}");
      AppLogger.instance.logger.i("FirebaseIdToekn => $newToken");
      AppLogger.instance.logger
          .i("User uid => ${firebaseAuth.currentUser?.uid}");

      final tokenFirebase = newToken;
      if (tokenFirebase == null) {
        throw Exception('Token Firebase introuvable');
      }

      AppLogger.instance.logger.i("tokenFirebase => $tokenFirebase");

      final response = await ApiResources.post(ApiRoutes.loginWithFirebase,
          data: {
            ApiParams.firebaseToken: newToken,
          },
          isFormData: false);

      final tokenLaravel = response.data[ApiParams.token] as String?;
      final laravelUser = response.data[ApiParams.utilisateur];
      final Map<String, dynamic> finalUser = {
        ...laravelUser,
        DatabaseAttributesResources.token: tokenLaravel,
      };

      if (tokenLaravel == null) {
        throw Exception('Token Laravel introuvable');
      }
      await ApiResources.setToken(tokenLaravel);

      AppLogger.instance.logger.i("finalUser => $finalUser");

      return ModelUser.fromJson(finalUser);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelAuthentication?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user != null ? ModelAuthentication() : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelAuthentication?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return result.user != null ? ModelAuthentication() : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelAuthentication?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // cancelled
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user != null ? ModelAuthentication() : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelAuthentication?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oAuthProvider = OAuthProvider("apple.com");
      final authCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      final result = await firebaseAuth.signInWithCredential(authCredential);
      return result.user != null ? ModelAuthentication() : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelAuthentication?> logoutUser() async {
    try {
      await firebaseAuth.signOut();
      return ModelAuthentication();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ModelAuthentication?> logoutUserToLaravel() async {
    try {
      final response = await ApiResources.post(ApiRoutes.logout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data);
      }
      await ApiResources.clearToken();
      return ModelAuthentication();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return;
    } catch (e) {
      throw Exception(e);
    }
  }
}
