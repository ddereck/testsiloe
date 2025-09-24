// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';


import '../controllers/post_logging_controller.dart' show PostLoggingController;
import '../features/launcher/adapters/launcher_controller.dart' show LauncherController;
import '../features/onboarding/adapters/onboarding_controller.dart' show OnboardingController;
import '../features/user/presentation/adapters/user_controller.dart';
import '../features/authentication/presentation/adapters/authentication_controller.dart';
import '../features/publication_type/presentation/adapters/publication_type_controller.dart';
import '../features/publication/presentation/adapters/publication_controller.dart';
import '../features/requete_priere/presentation/adapters/requete_priere_controller.dart';
import '../features/programme/presentation/adapters/programme_controller.dart';
import '../features/notification/presentation/adapters/notification_controller.dart';
import '../features/evenement_inscription/presentation/adapters/evenement_inscription_controller.dart';
import '../features/evenement/presentation/adapters/evenement_controller.dart';
import '../features/don/presentation/adapters/don_controller.dart';
import '../features/demande_rencontre/presentation/adapters/demande_rencontre_controller.dart';
import '../features/commentaire_report/presentation/adapters/commentaire_report_controller.dart';
import '../features/commentaire_reaction/presentation/adapters/commentaire_reaction_controller.dart';
import '../features/commentaire/presentation/adapters/commentaire_controller.dart';
import '../features/categorie/presentation/adapters/categorie_controller.dart';


class ControllersProvider {

  static final USER_CONTROLLER = Get.find<UserController>();
  static final AUTHENTICATION_CONTROLLER = Get.find<AuthenticationController>();
  static final PUBLICATION_TYPE_CONTROLLER = Get.find<PublicationTypeController>();
  static final PUBLICATION_CONTROLLER = Get.find<PublicationController>();
  static final REQUETE_PRIERE_CONTROLLER = Get.find<RequetePriereController>();
  static final PROGRAMME_CONTROLLER = Get.find<ProgrammeController>();
  static final NOTIFICATION_CONTROLLER = Get.find<NotificationController>();
  static final EVENEMENT_INSCRIPTION_CONTROLLER = Get.find<EvenementInscriptionController>();
  static final EVENEMENT_CONTROLLER = Get.find<EvenementController>();
  static final DON_CONTROLLER = Get.find<DonController>();
  static final DEMANDE_RENCONTRE_CONTROLLER = Get.find<DemandeRencontreController>();
  static final COMMENTAIRE_REPORT_CONTROLLER = Get.find<CommentaireReportController>();
  static final COMMENTAIRE_REACTION_CONTROLLER = Get.find<CommentaireReactionController>();
  static final COMMENTAIRE_CONTROLLER = Get.find<CommentaireController>();
  static final CATEGORIE_CONTROLLER = Get.find<CategorieController>();
  static final POST_LOGGING_CONTROLLER = Get.find<PostLoggingController>();
  static final LAUNCHER_CONTROLLER = Get.find<LauncherController>();
  static final ONBOARDING_CONTROLLER = Get.find<OnboardingController>();

}
