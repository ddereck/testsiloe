// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../bindings/app_bindings.dart';
import '../../features/authentication/presentation/ui/reset_password_ui.dart'
    show ResetPasswordUI;
import '../../features/evenement/presentation/ui/evenements_page.dart'
    show EvenementsPage;
import '../../features/publication/presentation/ui/update_article_ui.dart'
    show UpdateArticleUI;
import '../../features/requete_priere/presentation/ui/requete_priere.dart'
    show RequetePrierePage;
import '../../features/article/ui/add_article_ui.dart' show AddArticleUI;
import '../../features/article/ui/article_details_ui.dart'
    show ArticleDetailsUI;
import '../../features/authentication/presentation/ui/login_ui.dart'
    show LoginUI;
import '../../features/authentication/presentation/ui/register_ui.dart'
    show RegisterUI;
import '../../features/community/ui/community_ui.dart' show CommunityUI;
import '../../features/donations/ui/admin_donations_list_ui.dart'
    show AdminDonationsListUI;
import '../../features/donations/ui/donations_list_ui.dart'
    show DonationsListUI;
import '../../features/donations/ui/make_donation_ui.dart' show MakeDonationUI;
import '../../features/evenement/presentation/ui/upsert_event_ui.dart'
    show UpsertEventUI;
import '../../features/home/ui/home_ui.dart' show HomeUI;
import '../../features/launcher/ui/launcher_ui.dart' show LauncherUI;
import '../../features/onboarding/ui/onboarding_ui.dart' show OnboardingUI;
import '../../features/notifications/ui/notifications_ui.dart'
    show NotificationsUI;
import '../../features/rdv/ui/make_rdv_request_ui.dart'
    show MakeRdvRequestUI;
import '../../features/prayer/ui/prayer_request_details_ui.dart'
    show PrayerRequestDetailsUI;
import '../../features/rdv/ui/rdv_details_ui.dart'
    show RdvDetailsUI;
import '../../features/prayer/ui/prayer_requests_list_ui.dart'
    show PrayerRequestsListUI;
import '../../features/rdv/ui/rdvs_ui.dart' show RdvsUI;
import '../../features/reverend/ui/reverend_ui.dart' show ReverendUI;
import '../../features/editeurs/ui/editeurs_ui.dart' show EditeursUI;
import '../../features/evenement/presentation/ui/event_detail_page.dart';
import '../../features/settings/presentation/ui/settings_page.dart';

class AppRoutes {
  static const String settings = "/settings";
  static const String eventDetail = "/eventDetail";
  static const String home = "/home";
  static const String notifications = "/notifications";
  static const String launcher = "/launcher";
  static const String articleDetails = "/articleDetails";
  static const String onboarding = "/onboarding";
  static const String addArticle = "/addArticle";
  static const String updateArticle = "/updateArticle";
  static const String upsertEvent = "/upsertEvent";
  static const String donationsList = "/donationsList";
  static const String adminDonationsList = "/adminDonationsList";
  static const String sendDonation = "/sendDonation";

  static const String editeurs = "/editeurs";
  static const String reverend = "/reverend";

  static const String prayerRequestsList = "/prayerRequestsList";
  static const String sendPrayerRequest = "/sendPrayerRequest";
  static const String prayerRequestDetails = "/prayerRequestDetails";
  static const String rdvDetails = "/rdvDetails";
  static const String rdvs = "/rdvs";

  static const String requestRdv = "/requestRdv";

  static const String evenements = "/evenements";
  static const String community = "/community";

  static const String login = "/login";
  static const String register = "/register";
  static const String resetPassword = "/resetPassword";
}

/// A map of the routes and their corresponding widgets.
///
/// The map contains the following keys:
/// - [AppRoutes.home]: the splash page.
/// - [AppRoutes.launcher]: the home page.
Map<String, Widget Function(BuildContext)> getAppRoutes(BuildContext context) =>
    {
      AppRoutes.home: (context) => const HomeUI(),
      AppRoutes.launcher: (context) => const LauncherUI(),
    };

/// A list of the pages and their corresponding bindings.
///
/// The list contains the following pages:
/// - [AppRoutes.home]: the splash page.
/// - [AppRoutes.launcher]: the home page.
List<GetPage<dynamic>> getPages = [
  GetPage(
      name: AppRoutes.home,
      page: () => const HomeUI(),
      transition: Transition.zoom,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.launcher,
      page: () => const LauncherUI(),
      transition: Transition.noTransition,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingUI(),
      transition: Transition.rightToLeftWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.editeurs,
      page: () => EditeursUI(),
      transition: Transition.rightToLeftWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.reverend,
      page: () => const ReverendUI(),
      transition: Transition.rightToLeftWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.articleDetails,
      page: () => const ArticleDetailsUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.addArticle,
      page: () => const AddArticleUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.updateArticle,
      page: () => const UpdateArticleUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.upsertEvent,
      page: () => const UpsertEventUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.donationsList,
      page: () => const DonationsListUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.adminDonationsList,
      page: () => const AdminDonationsListUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.prayerRequestsList,
      page: () => const PrayerRequestsListUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.prayerRequestDetails,
      page: () => const PrayerRequestDetailsUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.sendPrayerRequest,
      page: () => RequetePrierePage(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.rdvs,
      page: () => const RdvsUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.rdvDetails,
      page: () => const RdvDetailsUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.sendDonation,
      page: () => const MakeDonationUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.requestRdv,
      page: () => const MakeRdvRequestUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.evenements,
      page: () => const EvenementsPage(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.community,
      page: () => CommunityUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.login,
      page: () => LoginUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.register,
      page: () => RegisterUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordUI(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.eventDetail,
      page: () => const EventDetailPage(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
  GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      transition: Transition.leftToRightWithFade,
      binding: AppBinding()),
];

/// A utility class for defining application-wide route utilities.
///
/// The class contains the following properties and methods:
/// - [route]: the route of the page.
/// - [arguments]: the arguments of the page.
/// - [replace]: whether to replace the current page with the new one.
/// - [rewrite]: whether to rewrite the current page with the new one.
/// - [buildPath]: a static method that builds the path of the pages.
/// - [changePage]: a static method that changes the current page.
class RoutesUtils {
  /// The route of the page.
  final String route;

  /// The arguments of the page.
  final dynamic arguments;

  /// Whether to replace the current page with the new one.
  final bool replace;

  /// Whether to rewrite the current page with the new one.
  final bool rewrite;

  /// Creates an instance of [RoutesUtils].
  const RoutesUtils(
      {required this.route,
      this.arguments,
      this.replace = false,
      this.rewrite = false});

  /// Builds the path of the pages.
  ///
  /// The method takes a list of [RoutesUtils] as an argument and builds the path
  /// of the pages.
  static Future<void> buildPath({required List<RoutesUtils> pages}) async {
    if (pages.isEmpty) return;

    for (final page in pages) {
      changePage(page.route,
          arguments: page.arguments,
          replace: page.replace,
          rewrite: page.rewrite);

      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  /// Changes the current page.
  ///
  /// The method takes the route of the page and its arguments as arguments.
  /// If [replace] is true, the current page is replaced with the new one.
  /// If [rewrite] is true, the current page is rewritten with the new one.
  static void changePage(String route,
      {dynamic arguments, bool replace = false, bool rewrite = false}) {
    if (replace) {
      Get.offAllNamed(route, arguments: arguments);
    } else if (rewrite) {
      Get.offNamed(route, arguments: arguments);
    } else {
      Get.toNamed(route, arguments: arguments);
    }
  }
}
