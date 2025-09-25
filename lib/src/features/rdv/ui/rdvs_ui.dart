import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/features/home/ui/widgets/floatting_bottom_nav.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/configs/time_config.dart' show TimeConfig;
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../di/di_helper.dart' show DiHelper;
import '../../../utils/text_config.dart' show TextConfig;
import '../../demande_rencontre/presentation/adapters/demande_rencontre_ui_controller.dart'
    show DemandeRencontreUiController;
import '../../home/adapters/home_ui_controller.dart';

class RdvsUI extends StatelessWidget {
  const RdvsUI({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final demandeRencontreUiController =
        DiHelper.findOrCreate(creator: () => DemandeRencontreUiController())
          ..initDemandeRencontres();
    //
    final homeUiController = DiHelper.findOrCreate(creator: () => HomeUIController());
    return Stack(
      children: [
        Column(
          children: [
            TopbarWidget(
                title: "Rendez-vous",),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstantsUtils.scaffoldHPadding,
                        vertical: AppConstantsUtils.scaffoldHPadding,
                      ),
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "Pointer une date pour marquer vos jours de disponibilité",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () => demandeRencontreUiController.toggleCalendar(),
                                      child: Icon(
                                        demandeRencontreUiController.showCalendar.value
                                            ? TablerIcons.chevron_up
                                            : TablerIcons.chevron_down,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (demandeRencontreUiController.showCalendar.value) ...[
                              const SizedBox(height: AppConstantsUtils.itemSpacing),
                              Obx(
                                () => TableCalendar(
                                  firstDay: DateTime.now(),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: demandeRencontreUiController
                                          .rencontreDateController.value ??
                                      DateTime.now(),
                                  selectedDayPredicate: (day) {
                                    return isSameDay(
                                        day,
                                        demandeRencontreUiController
                                            .rencontreDateController.value);
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    demandeRencontreUiController
                                        .rencontreDateController
                                        .value = selectedDay;
                                  },
                                ),
                              )
                            ],
                          ],
                        );
                      }),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: TabBar(
                      controller: demandeRencontreUiController.rdvTabController,
                      tabs: demandeRencontreUiController.myRdvTabs,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      indicatorColor: Colors.red.shade900,
                      labelStyle: TextConfig.getSimpleTextStyle(true),
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: demandeRencontreUiController.rdvTabController,
                      children: [
                        // Contenu onglet "Demandes"
                        Obx(() {
                          if (demandeRencontreUiController
                              .filterAllDemandeRencontres.isEmpty) {
                            return const Center(
                              child: Text("Chargement.."),
                            );
                          }
                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: demandeRencontreUiController
                                .filterAllDemandeRencontres.length,
                            separatorBuilder: (context, index) => const SizedBox(
                                height: AppConstantsUtils.itemSpacing),
                            itemBuilder: (context, index) {
                              final item = demandeRencontreUiController
                                  .filterAllDemandeRencontres[index];
                              return Container(
                                padding: const EdgeInsets.all(
                                    AppConstantsUtils.itemSpacing),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(
                                      AppConstantsUtils.radius),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage('assets/images/avatar.jpg'),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.nomPrenoms ?? 'Anonyme',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (item.objet != null)
                                            Text(
                                              item.objet!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    InkWell(
                                      onTap: () {
                                        RoutesUtils.changePage(
                                          AppRoutes.rdvDetails,
                                          arguments: item,
                                        );
                                      },
                                      child: const Icon(
                                          TablerIcons.circle_arrow_right_filled),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                        Obx(() {
                          // On filtre ici uniquement les rdvs acceptés
                          final acceptedRdvs = demandeRencontreUiController
                              .filterMesDemandeRencontres
                              .where((rdv) => rdv.statut == "acceptee")
                              .toList();

                          if (acceptedRdvs.isEmpty) {
                            return const Center(
                              child: Text("Aucun rendez-vous accepté"),
                            );
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: acceptedRdvs.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: AppConstantsUtils.itemSpacing),
                            itemBuilder: (context, index) {
                              final item = acceptedRdvs[index];
                              return Container(
                                padding: const EdgeInsets.all(AppConstantsUtils.itemSpacing),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(AppConstantsUtils.radius),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(item.nomPrenoms ?? 'Anonyme'),
                                    ),
                                    Text(
                                      TimeConfig.formatDateFr(item.date),
                                      style: TextConfig.getSimpleTextStyle(true),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Obx(
          () => FloatingBottomNav(
            selectedIndex: homeUiController.tabIndex.value,
            onItemTapped: (index) {
              Get.back();
              homeUiController.changeTabIndex(index);
            },
          ),
        ),
      ],
    ).emptyScaffold;
  }
}
