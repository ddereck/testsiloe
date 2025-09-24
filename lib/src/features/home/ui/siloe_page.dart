import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/glass_effect_extension.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/core/utils/all_utils.dart';
import 'package:siloe/src/features/home/ui/widgets/new_top_bar_header.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../di/di_helper.dart' show DiHelper;
import '../adapters/home_ui_controller.dart' show HomeUIController;
import 'dart:async';

class SiloePage extends StatelessWidget {
  const SiloePage({super.key});

  @override
  Widget build(BuildContext context) {
    DiHelper.findOrCreate(creator: () => HomeUIController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF7A0C0C),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Stack(
        children: [
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/background_siloe.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SafeArea(
            child: Column(
              children: [
                TopBarWidget().paddingSymmetric(
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
                      _SectionHeader(title: 'ÉVÉNEMENTS ET PROGRAMME'),
                      SizedBox(height: 8),
                      _BannerSlider(),
                      // SizedBox(height: 16),
                      // _SectionHeader(title: 'Evenement et programmes'),
                      SizedBox(height: 8),
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
          // Couverture complète de la barre de statut avec la couleur thème
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Builder(builder: (context) {
              final top = MediaQuery.of(context).padding.top;
              return Container(height: top, color: const Color(0xFF7A0C0C));
            }),
          ),
          // Floating WhatsApp button
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

class _BannerSlider extends StatefulWidget {
  const _BannerSlider();
  @override
  State<_BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<_BannerSlider> {
  final PageController _controller = PageController(viewportFraction: 1);
  int _index = 0;
  Timer? _timer;
  final List<_BannerData> _banners = const [
    _BannerData(
      image: 'assets/images/image1.png',
      title: "Campagne d'evangelisation",
      subtitle: 'Du 10 au 30 Août 2025',
    ),
    _BannerData(
      image: 'assets/images/image2.png',
      title: 'Nuit de délivrance',
      subtitle: '26/09/25 de 22h à 05h',
    ),
    _BannerData(
      image: 'assets/images/image1.png',
      title: "Campagne de Paques",
      subtitle: 'Du 10 au 30 Août 2025',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (!mounted) return;
      final next = (_index + 1) % _banners.length;
      _controller.animateToPage(
        next,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _banners.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (_, i) {
                    final b = _banners[i];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(b.image, fit: BoxFit.cover),
                        // Title and subtitle overlay
                        Positioned(
                          bottom: 10,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.4), // fond semi-transparent
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  b.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  b.subtitle,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
                        // Programme de culte card
                        Positioned(
                          left: 8,
                          right: 8,
                          bottom: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Text(
                                    'Programme hebdomadaire',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: const [
                                    Expanded(child: _ScheduleColumn()),
                                    SizedBox(width: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _ScheduleColumn extends StatelessWidget {
  const _ScheduleColumn();
  @override
  Widget build(BuildContext context) {
    Text _row(String day, String hour, String gram) => Text.rich(
          TextSpan(children: [
            TextSpan(text: '$day  ', style: const TextStyle(fontSize: 10)),
            TextSpan(
                text: hour,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            TextSpan(text: '$gram  ', style: const TextStyle(fontSize: 10)),
          ]),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Lundi', '06h – 07h' ,': Café chaud'),
        _row('Mercredi', '19h – 21h' ,': Étude Biblique'),
        _row('Jeudi', '11h – 18h' ,': Rencontre avec le Révérend'),
        _row('Vendredi', '19h – 20h' ,': Maisons d\'accueil'),
        _row('Dimanche', '08h – 10h45' ,': Culte de célébration'),
      ],
    );
  }
}

class _BannerData {
  final String image;
  final String title;
  final String subtitle;
  const _BannerData(
      {required this.image, required this.title, required this.subtitle});
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
            color: Colors.black.withValues(alpha: 0.08),
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
            color: Colors.black.withValues(alpha: 0.08),
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
            color: Colors.black.withValues(alpha: 0.08),
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
