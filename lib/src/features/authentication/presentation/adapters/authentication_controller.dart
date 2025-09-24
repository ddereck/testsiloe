import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:siloe/src/core/logs/custom_logger.dart';
import 'package:siloe/src/core/resources/params.dart';
import 'package:google_sign_in/google_sign_in.dart';


// UseCases
import '../../../user/domain/entities/entity_user.dart' show EntityUser;
import '../../domain/usecases/logout_user_to_laravel_usecase.dart'
    show LogoutUserToLaravelUseCase;
import '../../domain/usecases/reset_password_usecase.dart'
    show ResetPasswordUseCase, ResetPasswordUseCaseParams;
import '../../domain/usecases/sign_in_to_laravel_usecase.dart'
    show SignInToLaravelUseCase, SignInToLaravelUseCaseParams;
import '../../domain/usecases/sign_in_with_email_and_password_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart'
    show SignInWithGoogleUseCase;
import '../../domain/usecases/sign_in_with_apple_usecase.dart'
    show SignInWithAppleUseCase;
import '../../domain/usecases/logout_user_usecase.dart';
import '../../domain/usecases/sign_up_with_email_and_password_usecase.dart'
    show
        SignUpWithEmailAndPasswordUseCase,
        SignUpWithEmailAndPasswordUseCaseParams;

class AuthenticationController extends GetxController {
  final SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase;
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final LogoutUserUseCase logoutUserUseCase;
  final SignInToLaravelUseCase signInToLaravelUseCase;
  final LogoutUserToLaravelUseCase logoutUserToLaravelUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final SignInWithAppleUseCase signInWithAppleUseCase;

  AuthenticationController({
    required this.signUpWithEmailAndPasswordUseCase,
    required this.signInWithEmailAndPasswordUseCase,
    required this.logoutUserUseCase,
    required this.signInToLaravelUseCase,
    required this.logoutUserToLaravelUseCase,
    required this.resetPasswordUseCase,
    required this.signInWithGoogleUseCase,
    required this.signInWithAppleUseCase,
  });

  Future<VoidType?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await signUpWithEmailAndPasswordUseCase.call(
          SignUpWithEmailAndPasswordUseCaseParams(
              email: email, password: password));

      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while signing up: ${result.$2.toString()}",
            error: result.$2);
        return null;
      }

      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e("Error while signing up: $e");
      return null;
    }
  }

  Future<VoidType?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await signInWithEmailAndPasswordUseCase.call(
          SignInWithEmailAndPasswordUseCaseParams(
              email: email, password: password));

      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while signing in: ${result.$2.toString()}",
            error: result.$2);
        return null;
      }

      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e("Error while signing in: $e");
      return null;
    }
  }

  Future<VoidType?> signInWithGoogle() async {
    try {
      final result = await signInWithGoogleUseCase.call(VoidType());
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while Google sign-in: ${result.$2.toString()}",
            error: result.$2);
        return null;
      }
      return VoidType();
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: false);
      AppLogger.instance.logger.e("Error while Google sign-in: $e");
      return null;
    }

  }

  Future<VoidType?> signInWithApple() async {
    try {
      final result = await signInWithAppleUseCase.call();
      if (result.$1 != null) {
        AppLogger.instance.logger.e(
            "Error while Apple sign-in: ${result.$2.toString()}",
            error: result.$2);
        return null;
      }
      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e("Error while Apple sign-in: $e");
      return null;
    }
  }

  Future<VoidType?> logoutUser() async {
    try {
      // Déconnexion Firebase 
      final response = await logoutUserUseCase.call(NoParams());

      // Déconnexion Google
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect(); // force l’oublie du compte

      if (response.$1 != null) {
        AppLogger.instance.logger.e(response.$2.toString(), error: response.$2);
        return null;
      }
      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e(e.toString(), error: e);
      return null;
    }
  }

  Future<EntityUser?> signInToLaravel({String? firebaseToken}) async {
    try {
      final response = await signInToLaravelUseCase
          .call(SignInToLaravelUseCaseParams(firebaseToken: firebaseToken));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(response.$2.toString(), error: response.$2);
        return null;
      }
      return response.$2;
    } catch (e) {
      AppLogger.instance.logger.e(e.toString(), error: e);
      return null;
    }
  }

  Future<VoidType?> logoutUserToLaravel() async {
    try {
      final response = await logoutUserToLaravelUseCase.call(NoParams());
      if (response.$1 != null) {
        AppLogger.instance.logger.e(response.$2.toString(), error: response.$2);
        return null;
      }
      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e(e.toString(), error: e);
      return null;
    }
  }

  Future<VoidType?> resetPassword({required String email}) async {
    try {
      final response = await resetPasswordUseCase
          .call(ResetPasswordUseCaseParams(email: email));
      if (response.$1 != null) {
        AppLogger.instance.logger.e(response.$2.toString(), error: response.$2);
        return null;
      }
      return VoidType();
    } catch (e) {
      AppLogger.instance.logger.e(e.toString(), error: e);
      return null;
    }
  }
}
