import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../home/ui/widgets/floatting_bottom_nav.dart' show FloatingBottomNav;
import '../adapters/reverend_ui_controller.dart';

class ReverendUI extends GetView<ReverendUIController> {
  const ReverendUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReverendUIController());
    final List<_RevItem> items = [
      _RevItem(
        title: 'Les demandes de rencontres',
        imagePath: 'assets/images/reverend.png',
        badge: controller.rdvCount,
        onTapRoute: AppRoutes.rdvs,
      ),
      _RevItem(
        title: 'Requêtes de prière',
        imagePath: 'assets/images/priere.png',
        badge: controller.prayerRequestCount,
        onTapRoute: AppRoutes.prayerRequestsList,
      ),
      _RevItem(
        title: 'Dons',
        imagePath: 'assets/images/don.png',
        badge: controller.donationCount,
        onTapRoute: AppRoutes.adminDonationsList,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopbarWidget(title: "Reverend"),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: AppConstantsUtils.scaffoldHPadding,
                    right: AppConstantsUtils.scaffoldHPadding,
                    bottom: AppConstantsUtils.scaffoldHPadding,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final it = items[index];
                    return _RevCard(
                      title: it.title,
                      imagePath: it.imagePath,
                      badge: it.badge,
                      onTap: () {
                        if (it.onTapRoute != null) {
                          RoutesUtils.changePage(it.onTapRoute!);
                        }
                      },
                    ).paddingOnly(top: index == 0 ? 8 : 12);
                  },
                ),
              ),
            ],
          ),
          FloatingBottomNav(
            selectedIndex: 1,
            onItemTapped: (i) {
              if (i == 0) {
                RoutesUtils.changePage(AppRoutes.home);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _RevCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final RxInt badge;
  final VoidCallback onTap;
  const _RevCard(
      {required this.title,
      required this.imagePath,
      required this.badge,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 120,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.black54),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Reverend',
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Obx(() {
              if (badge.value > 0) {
                return Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEB3B3B),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    badge.value.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class _RevItem {
  final String title;
  final String imagePath;
  final RxInt badge;
  final String? onTapRoute;

  const _RevItem({
    required this.title,
    required this.imagePath,
    required this.badge,
    this.onTapRoute,
  });
}

