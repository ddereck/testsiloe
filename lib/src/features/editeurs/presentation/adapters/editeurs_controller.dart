import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/editeur_model.dart';
import '../../domain/usecases/get_editeurs_usecase.dart';
import '../../domain/usecases/get_user_by_email_usecase.dart';
import '../../domain/usecases/nommer_editeur_usecase.dart';
import '../../domain/usecases/retirer_editeur_usecase.dart';

class EditeursController extends GetxController {
  final GetEditeursUseCase getEditeursUseCase;
  final GetUserByEmailUseCase getUserByEmailUseCase;
  final NommerEditeurUseCase nommerEditeurUseCase;
  final RetirerEditeurUseCase retirerEditeurUseCase;

  // Controllers
  final TextEditingController emailController = TextEditingController();

  // Observable variables
  final RxList<EditeurModel> editeurs = <EditeurModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  EditeursController({
    required this.getEditeursUseCase,
    required this.getUserByEmailUseCase,
    required this.nommerEditeurUseCase,
    required this.retirerEditeurUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    loadEditeurs();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> loadEditeurs() async {
    try {
      isLoading.value = true;
      // Ne pas vider immédiatement pour éviter un clignotement agressif

      final result = await getEditeursUseCase();
      editeurs.value = result;
      // Clear error only on success
      errorMessage.value = '';
      
      // Debug: afficher le nombre d'éditeurs chargés
      print('Éditeurs chargés: ${result.length}');
    } catch (e) {
      // Conserver l'ancien message si déjà présent, sinon définir le nouveau
      if (errorMessage.value.isEmpty) {
        errorMessage.value = 'Erreur lors du chargement des éditeurs: $e';
      }
      print('Erreur loadEditeurs: $e'); // Debug
      
      // En cas d'erreur, on garde la liste existante ou on la vide
      if (editeurs.isEmpty) {
        editeurs.value = [];
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addEditeur(String email) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Validation email basique
      if (!email.contains('@') || !email.contains('.')) {
        errorMessage.value = 'Veuillez saisir un email valide';
        return false;
      }

      final user = await getUserByEmailUseCase(email);
      if (user == null) {
        // Debug
        // ignore: avoid_print
        print('addEditeur → getUserByEmailUseCase a retourné null pour "$email"');
        errorMessage.value = 'Utilisateur non trouvé avec cet email';
        return false;
      }

      // Debug
      // ignore: avoid_print
      print('addEditeur → utilisateur trouvé (id=${user.id}, email=${user.email})');

      // Vérifier si l'utilisateur est déjà éditeur
      final isAlreadyEditor = editeurs.any((editor) => editor.id == user.id);
      if (isAlreadyEditor) {
        errorMessage.value = 'Cet utilisateur est déjà éditeur';
        return false;
      }

      // Debug
      // ignore: avoid_print
      print('addEditeur → appel nommerEditeurUseCase(${user.id})');
      final success = await nommerEditeurUseCase(user.id);
      if (success) {
        await loadEditeurs(); // Recharger la liste
        emailController.clear(); // Clear input after success
        return true;
      } else {
        errorMessage.value = 'Erreur lors de la nomination';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Erreur: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> removeEditeur(int userId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final success = await retirerEditeurUseCase(userId);
      if (success) {
        await loadEditeurs(); // Recharger la liste
        return true;
      } else {
        errorMessage.value = 'Erreur lors du retrait';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Erreur: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }
}
