import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetxController, Rx;
import 'package:siloe/src/core/logs/custom_logger.dart';

import '../../../../commons/functions/widgets_functions.dart'
    show customSnackBar;
import '../../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../../di/controllers_provider.dart';

class AuthUIController extends GetxController {
  final loginFormState = GlobalKey<FormState>();
  final registerFormState = GlobalKey<FormState>();
  final resetPasswordFormState = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmedController =
      TextEditingController();

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmedController.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  Rx<bool> isLoginSubmitting = Rx<bool>(false);
  void setIsLoginSubmitting(bool value) {
    isLoginSubmitting.value = value;
    update();
  }

  Rx<bool> isRegisterSubmitting = Rx<bool>(false);
  void setIsRegisterSubmitting(bool value) {
    isRegisterSubmitting.value = value;
    update();
  }

  Rx<bool> isLogoutSubmitting = Rx<bool>(false);
  void setIsLogoutSubmitting(bool value) {
    isLogoutSubmitting.value = value;
    update();
  }

  Rx<bool> isGoogleSubmitting = Rx<bool>(false);
  void setIsGoogleSubmitting(bool value) {
    isGoogleSubmitting.value = value;
    update();
  }

  Rx<bool> isAppleSubmitting = Rx<bool>(false);
  void setIsAppleSubmitting(bool value) {
    isAppleSubmitting.value = value;
    update();
  }

  Rx<String?> firebaseToken = Rx<String?>(null);
  void setFirebaseToken(String? value) {
    firebaseToken.value = value;
    update();
  }

  Future<void> submitLogin() async {
    if (!loginFormState.currentState!.validate()) return;

    isLoginSubmitting.value = true;
    update();
    final response = await ControllersProvider.AUTHENTICATION_CONTROLLER
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    isLoginSubmitting.value = false;
    update();
    if (response != null) {
      // Login Laravel
      final responseLaravel =
          await ControllersProvider.AUTHENTICATION_CONTROLLER.signInToLaravel(
              firebaseToken:
                  ControllersProvider.USER_CONTROLLER.getUserFirebaseId());
      if (responseLaravel != null) {
        AppLogger.instance.logger.i(responseLaravel);
        ControllersProvider.USER_CONTROLLER.setUserValue(responseLaravel);
        RoutesUtils.changePage(AppRoutes.launcher);
        return;
      } else {
        AppLogger.instance.logger.i(responseLaravel);
      }
    }
    loginFormState.currentState?.reset();
    customSnackBar(
        title: "Erreur de connexion",
        message:
            "Une erreur est survenue lors de la connexion. Veuillez réessayer");
  }

  Future<void> submitRegister() async {
    if (!registerFormState.currentState!.validate()) return;

    isRegisterSubmitting.value = true;
    update();
    final response = await ControllersProvider.AUTHENTICATION_CONTROLLER
        .signUpWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    isRegisterSubmitting.value = false;
    update();
    if (response != null) {
      // Login Laravel
      final responseLaravel =
          await ControllersProvider.AUTHENTICATION_CONTROLLER.signInToLaravel(
              firebaseToken:
                  ControllersProvider.USER_CONTROLLER.getUserFirebaseId());
      if (responseLaravel != null) {
        AppLogger.instance.logger.i(responseLaravel);
        ControllersProvider.USER_CONTROLLER.setUserValue(responseLaravel);
        RoutesUtils.changePage(AppRoutes.launcher);
        return;
      } else {
        AppLogger.instance.logger.i(responseLaravel);
      }
    }
    registerFormState.currentState?.reset();
    customSnackBar(
        title: "Erreur de connexion",
        message:
            "Une erreur est survenue lors de l'inscription. Veuillez réessayer");
  }

  Future<void> submitLogout() async {
    isLogoutSubmitting.value = true;
    update();
    final response =
        await ControllersProvider.AUTHENTICATION_CONTROLLER.logoutUser();
    isLogoutSubmitting.value = false;
    update();
    if (response != null) {
      // Logout Laravel
      final responseLaravel = await ControllersProvider
          .AUTHENTICATION_CONTROLLER
          .logoutUserToLaravel();
      if (responseLaravel != null) {
        RoutesUtils.changePage(AppRoutes.launcher, replace: true);
        return;
      }
      customSnackBar(
          title: "Erreur de déconnexion",
          message:
              "Une erreur est survenue lors de la déconnexion. Veuillez réessayer");
      return;
    }
  }

  Future<void> submitLoginWithGoogle() async {
    try {
      isGoogleSubmitting.value = true;
      update();
      final response =
      await ControllersProvider.AUTHENTICATION_CONTROLLER.signInWithGoogle();
      isGoogleSubmitting.value = false;
      update();
      if (response != null) {
        final responseLaravel =
        await ControllersProvider.AUTHENTICATION_CONTROLLER.signInToLaravel(
            firebaseToken:
            ControllersProvider.USER_CONTROLLER.getUserFirebaseId());
        if (responseLaravel != null) {
          ControllersProvider.USER_CONTROLLER.setUserValue(responseLaravel);
          RoutesUtils.changePage(AppRoutes.launcher);
          return;
        }
      }
      customSnackBar(
          title: "Erreur de connexion",
          message:
          "Une erreur est survenue lors de la connexion Google. Veuillez réessayer");
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: false);
    }
  }

  Future<void> submitLoginWithApple() async {
    isAppleSubmitting.value = true;
    update();
    final response =
        await ControllersProvider.AUTHENTICATION_CONTROLLER.signInWithApple();
    isAppleSubmitting.value = false;
    update();
    if (response != null) {
      final responseLaravel =
          await ControllersProvider.AUTHENTICATION_CONTROLLER.signInToLaravel(
              firebaseToken:
                  ControllersProvider.USER_CONTROLLER.getUserFirebaseId());
      if (responseLaravel != null) {
        ControllersProvider.USER_CONTROLLER.setUserValue(responseLaravel);
        RoutesUtils.changePage(AppRoutes.launcher);
        return;
      }
    }
    customSnackBar(
        title: "Erreur de connexion",
        message:
            "Une erreur est survenue lors de la connexion Apple. Veuillez réessayer");
  }

  Rx<bool> isResetPasswordSubmitting = Rx<bool>(false);
  Future<void> submitResetPassword() async {
    if (!resetPasswordFormState.currentState!.validate()) return;

    isResetPasswordSubmitting.value = true;
    update();
    final response =
        await ControllersProvider.AUTHENTICATION_CONTROLLER.resetPassword(
      email: emailController.text,
    );
    isResetPasswordSubmitting.value = false;
    update();
    if (response != null) {
      customSnackBar(
          title: "Mot de passe en cours de modification",
          message:
              "Véuillez consulter votre boite mail pour modifier votre mot de passe via le lien envoyé");
      resetPasswordFormState.currentState?.reset();
    }
  }

  Rx<bool> isCurrentlyLogin = Rx<bool>(false);
  void setIsCurrentlyLogin(bool value) {
    isCurrentlyLogin.value = value;
    update();
  }
}
