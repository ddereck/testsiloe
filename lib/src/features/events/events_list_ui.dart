import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../commons/ui/widgets/topbar_widget.dart';
import '../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../di/controllers_provider.dart' show ControllersProvider;
import '../../di/di_helper.dart' show DiHelper;
import '../../utils/text_config.dart';
import '../evenement/presentation/adapters/evenement_ui_controller.dart' show EvenementUIController;
import '../evenement/presentation/ui/widgets/event_widget.dart' show EventWidget;

class EventsListUI extends StatelessWidget {
  const EventsListUI({super.key});

  @override
  Widget build(BuildContext context) {
    final evenementUiController =
        DiHelper.findOrCreate(creator: () => EvenementUIController())
        ..initEvenements();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(title: "Evènements"),
        Expanded(
          child: CustomScrollView(
            slivers: [
              if(ControllersProvider.USER_CONTROLLER.userRole.value?.isAdminOrReverend ?? false) ...[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstantsUtils.containerHPadding,
                    vertical: AppConstantsUtils.containerVPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () {
                        RoutesUtils.changePage(AppRoutes.upsertEvent);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstantsUtils.containerHPadding,
                          vertical: AppConstantsUtils.containerVPadding * 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Icon(TablerIcons.circle_plus_filled,
                                size: AppConstantsUtils.iconSizeLarge),
                            Text(
                              "Ajouter".toUpperCase(),
                              style: TextConfig.getSimpleTextStyle(true, size: AppConstantsUtils.subTitleSize),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              // Liste des évènements
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: AppConstantsUtils.containerHPadding,
                  right: AppConstantsUtils.containerHPadding,
                  top: AppConstantsUtils.containerVPadding,
                ),
                sliver: Obx(() {

                  if(evenementUiController.evenements.value.isEmpty) {
                    return SliverToBoxAdapter(
                      child: const Center(child: Text("Aucun évènement")),
                    );
                  }

                  return SliverList.separated(
                  itemCount: evenementUiController.evenements.value.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppConstantsUtils.itemSpacing),
                  itemBuilder: (context, index) {
                    final item = evenementUiController.evenements.value[index];
                    return EventWidget(evenement: item);
                  },
                );
                }),
              ),
            ],
          ),
        ),
      ],
    ).emptyScaffold;
  }
}
