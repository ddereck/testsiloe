import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:siloe/src/commons/extensions/glass_effect_extension.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/core/utils/all_utils.dart';
import 'package:siloe/src/features/home/ui/widgets/new_top_bar_header.dart';
import 'package:siloe/src/di/controllers_provider.dart';
import 'package:siloe/src/features/evenement/presentation/adapters/evenement_ui_controller.dart';
import 'package:siloe/src/features/evenement/presentation/data/event_datas.dart';
import 'package:siloe/src/features/user/domain/enums/user_role_enums.dart';
import 'package:siloe/src/utils/image_utils.dart';

import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../di/di_helper.dart' show DiHelper;
import '../adapters/home_ui_controller.dart' show HomeUIController;

class SiloePage extends StatelessWidget {
  const SiloePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    DiHelper.findOrCreate(creator: () => HomeUIController());
    DiHelper.findOrCreate(creator: () => EvenementUIController())
        .initEvenements();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF7A0C0C),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                TopBarWidget()
                    .paddingSymmetric(
                        horizontal: AppConstantsUtils.scaffoldHPadding)
                    .withGlassEffect(
                        blur: 15,
                        opacity: 0.5,
                        borderRadius: BorderRadius.zero),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      left: AppConstantsUtils.scaffoldHPadding,
                      right: AppConstantsUtils.scaffoldHPadding,
                      bottom: AppConstantsUtils.scaffoldHPadding,
                    ),
                    children: const [
                      _SectionHeader(title: 'ÉVÉNEMENTS'),
                      SizedBox(height: 8),
                      _EventSlider(),
                      SizedBox(height: 16),
                      _SectionHeader(title: 'PROGRAMME DE LA SEMAINE'),
                      SizedBox(height: 8),
                      _ScheduleCard(),
                      SizedBox(height: 16),
                      _ServiceCard(),
                      SizedBox(height: 12),
                      _InfoCard(),
                      SizedBox(height: 12),
                      _DonationCard(),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Builder(builder: (context) {
              final top = MediaQuery.of(context).padding.top;
              return Container(height: top, color: const Color(0xFF7A0C0C));
            }),
          ),
          Positioned(
            right: AppConstantsUtils.scaffoldHPadding,
            bottom: AppConstantsUtils.scaffoldHPadding,
            child: Material(
              color: const Color(0xFF25D366),
              shape: const CircleBorder(),
              elevation: 4,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  AppAllUtils.openWhatsapp("2290164646463");
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/whatsapp.png',
                    width: 26,
                    height: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).simpleScaffold;
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}

class _EventSlider extends StatefulWidget {
  const _EventSlider();
  @override
  State<_EventSlider> createState() => _EventSliderState();
}

class _EventSliderState extends State<_EventSlider> {
  late PageController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1);
    final evenementUiController = Get.find<EvenementUIController>();
    if (evenementUiController.evenements.value.isNotEmpty) {
      _startTimer(evenementUiController.evenements.value.length);
    }
    evenementUiController.evenements.listen((events) {
      if (events.isNotEmpty) {
        _startTimer(events.length);
      } else {
        _timer?.cancel();
      }
    });
  }

  void _startTimer(int pageCount) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (!mounted || pageCount == 0 || !_controller.hasClients) return;
      final nextPage = (_controller.page!.toInt() + 1) % pageCount;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMMM yyyy', 'fr_FR').format(date);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final evenementUiController = Get.find<EvenementUIController>();

    return Obx(() {
      if (evenementUiController.isLoading.value) {
        return const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (evenementUiController.evenements.value.isEmpty) {
        return const SizedBox(
          height: 200,
          child: Center(child: Text("Aucun événement à venir.")),
        );
      }
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: PageView.builder(
          controller: _controller,
          itemCount: evenementUiController.evenements.value.length,
          itemBuilder: (_, i) {
            final event = evenementUiController.evenements.value[i];
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.eventsAndPrograms, arguments: event);
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (event.imageDeCouverture != null)
                      CachedNetworkImage(
                        imageUrl:
                            ImageUtils.buildImageUrl(event.imageDeCouverture!),
                        fit: BoxFit.cover,
                      ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 14,
                      right: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.theme ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(event.dateEvenement),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      final user =
                          ControllersProvider.USER_CONTROLLER.user.value;
                      if (user != null &&
                          user.roles.any(
                              (role) => role.toUserRole().isAdminOrReverend)) {
                        return Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              Get.toNamed(AppRoutes.upsertEvent,
                                  arguments: {EventDatas.evenementArg: event});
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    })
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Programme hebdomadaire',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _ScheduleRow('Lundi', '06h – 07h', 'Café chaud'),
          _ScheduleRow('Mercredi', '19h – 21h', 'Étude Biblique'),
          _ScheduleRow('Jeudi', '11h – 18h', 'Rencontre avec le Révérend'),
          _ScheduleRow('Vendredi', '19h – 20h', 'Maisons d\'accueil'),
          _ScheduleRow('Dimanche', '08h – 10h45', 'Culte de célébration'),
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final String day;
  final String time;
  final String activity;

  const _ScheduleRow(this.day, this.time, this.activity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '$day: ',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: activity),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/reverend.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'Besoin de rencontrer le Révérend pour conseils, suivi et assistance spirituelle ?',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A0C0C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () =>
                        RoutesUtils.changePage(AppRoutes.requestRdv),
                    child: const Text('Prendre RDV'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notre communauté veut te soutenir dans la prière face à tes épreuves et défis quotidiens.\nÉcris-nous ta requête.',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A0C0C),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () =>
                      RoutesUtils.changePage(AppRoutes.sendPrayerRequest),
                  child: const Text(
                    'Requête de prière',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/image2.png',
              width: 120,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonationCard extends StatelessWidget {
  const _DonationCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "Votre générosité permet à notre communauté de répandre la bonne nouvelle, de partager l'amour de Dieu et d'apporter aide et réconfort à ceux qui sont dans le besoin.",
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7A0C0C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 0,
            ),
            onPressed: () => RoutesUtils.changePage(AppRoutes.sendDonation),
            child: const Text(
              'Faire un don',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}