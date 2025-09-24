import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// UseCases
import '../../../../core/logs/custom_logger.dart' show AppLogger;
import '../../../../core/resources/firebase_resources.dart'
    show FirebaseResources;
import '../../../../core/resources/params.dart' show NoParams;
import '../../../../di/di_helper.dart' show DiHelper;
import '../../../authentication/presentation/adapters/auth_ui_controller.dart' show AuthUIController;
import '../../domain/entities/entity_user.dart' show EntityUser;
import '../../domain/enums/user_role_enums.dart' show UserRoleEnums, UserRoleEnumsExtension;
import '../../domain/usecases/get_all_users_usecase.dart' show GetAllUsersUseCase, GetAllUsersUseCaseParams;
import '../../domain/usecases/get_user_by_id_usecase.dart';
import '../../domain/usecases/get_user_photo_usecase.dart';
import '../../domain/usecases/ban_user_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/delete_current_user_account_usecase.dart';
import '../../domain/usecases/unban_user_usecase.dart' show UnbanUserUseCase;
import '../../domain/usecases/update_user_usecase.dart' show UpdateUserUseCase;

class UserController extends GetxController {
  final GetUserByIdUseCase getUserByIdUseCase;
  final DeleteCurrentUserAccountUseCase deleteCurrentUserAccountUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final BanUserUseCase banUserUseCase;
  final UnbanUserUseCase unbanUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final UpdateUserPhotoUseCase updateUserPhotoUseCase;

  UserController({
    required this.getUserByIdUseCase,
    required this.deleteCurrentUserAccountUseCase,
    required this.getCurrentUserUseCase,
    required this.getAllUsersUseCase,
    required this.banUserUseCase,
    required this.unbanUserUseCase,
    required this.updateUserUseCase,
    required this.updateUserPhotoUseCase,
  });

  Rx<EntityUser?> user = Rx<EntityUser?>(null);
  Rx<UserRoleEnums?> userRole = Rx<UserRoleEnums?>(null);

  // Vérifie si l'utilisateur a un rôle donné
  bool hasRole(UserRoleEnums role) {
    final roles = user.value?.roles ?? [];
    return roles.any((r) => r.toUserRole() == role);
  }

  // Vérifie si user est admin / révérend / éditeur
  bool get isAdminOrReverendOrEditeur {
    final roles = user.value?.roles ?? [];
    return roles.any((r) {
      final role = r.toUserRole();
      return role.isAdminOrReverendOrEditeur;
    });
  }


  void setUserValue(EntityUser? value) {
    user.value = value;
    update();

    if(user.value?.statut != null) {
      userRole.value = user.value?.profil?.toUserRole();
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    listenUser();
  }

  Future<void> listenUser() async {
    try {
      final authUiController = DiHelper.findOrCreate(
        creator: () => AuthUIController(),
      );
      FirebaseResources.authStateChanges.listen((User? user) async {
        final token = await FirebaseResources.currentUser?.getIdToken(true);
        if (user == null) {
          debugPrint('User is currently signed out!');
          authUiController.setIsCurrentlyLogin(false);
          authUiController.setIsCurrentlyLogin(isUserSignedIn());
          authUiController.setFirebaseToken(null);
          setUserValue(null);
        } else {
          debugPrint('User is signed in!');
          authUiController.setIsCurrentlyLogin(true);
          authUiController.setIsCurrentlyLogin(isUserSignedIn());
          authUiController.setFirebaseToken(token);
          final newUser = await getCurrentUser();
          AppLogger.instance.logger.i("New user: $newUser");
          setUserValue(newUser);
        }
      });
    } catch (e) {
      AppLogger.instance.logger.e(e);
    }
  }

  String? getUserFirebaseId() => FirebaseResources.currentUser?.uid;
  bool isUserSignedIn() => FirebaseResources.currentUser != null;

  Future<EntityUser?> getCurrentUser() async {
    try {
      final result = await getCurrentUserUseCase.call(NoParams());
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting current user: ${result.$2.toString()}", error: result.$2);
        return null;
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting current user: $e");
      return null;
    }
  }

  Future<List<EntityUser>> getAllUsers({String? search}) async {
    try {
      final result = await getAllUsersUseCase.call(GetAllUsersUseCaseParams(
        search: search,
        statut: search,
        profil: search,
      ));
      if (result.$1 != null) {
        AppLogger.instance.logger.e("Error while getting all users: ${result.$2.toString()}", error: result.$2);
        return [];
      }
      return result.$2;
    } catch (e) {
      AppLogger.instance.logger.e("Error while getting all users: $e");
      return [];
    }
  }

}
