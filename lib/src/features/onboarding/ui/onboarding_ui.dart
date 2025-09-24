import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../onboarding/adapters/onboarding_controller.dart'
    show OnboardingController;

class OnboardingUI extends StatefulWidget {
  const OnboardingUI({super.key});

  @override
  State<OnboardingUI> createState() => _OnboardingUIState();
}

class _OnboardingUIState extends State<OnboardingUI> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF7A0C0C),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final pages = [
      _OnbPage(
          image: 'assets/images/splash1.png',
          title: "MISSION EVANGELIQUE LE RESERVOIR DE SILOE",
          subtitle: "Une église enracinée dans la Parole infaillible de Dieu"),
      _OnbPage(
          image: 'assets/images/splash2.png',
          title: "Un peuple en marche",
          subtitle:
              "Une famille spirituelle qui adore Dieu, marche dans la foi et annonce l’Évangile avec puissance pour transformer les nations.")
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 6, color: const Color(0xFF7A0C0C)),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (i) => controller.currentPage.value = i,
                itemBuilder: (_, i) => pages[i],
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (i) {
                  final isActive = controller.currentPage.value == i;
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF7A0C0C)
                          : const Color(0xFFB77C73),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              TextButton(
                onPressed: () async {
                  await controller.updateFirstOpening(false);
                  RoutesUtils.changePage(AppRoutes.launcher, replace: true);
                },
                child: Text('Passer',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black54)),
              ),
              const Spacer(),
              Obx(() {
                final isLast = controller.currentPage.value == pages.length - 1;
                return TextButton.icon(
                  onPressed: () async {
                    if (isLast) {
                      await controller.updateFirstOpening(false);
                      RoutesUtils.changePage(AppRoutes.launcher, replace: true);
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                    }
                  },
                  icon:
                      const Icon(Icons.arrow_forward, color: Color(0xFF7A0C0C)),
                  label: Text(isLast ? 'Terminer' : 'Suivant',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black87)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnbPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const _OnbPage(
      {required this.image, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(image, fit: BoxFit.contain)),
          const SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(subtitle, textAlign: TextAlign.center),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
