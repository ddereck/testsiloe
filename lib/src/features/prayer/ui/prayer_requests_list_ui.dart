import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../commons/ui/widgets/empty_widget.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
//import '../../../core/configs/time_config.dart' show TimeConfig;
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../di/di_helper.dart' show DiHelper;
import '../../requete_priere/presentation/adapters/requete_priere_ui_controller.dart'
    show RequetePriereUiController;
import '../adapters/datas.dart';

class PrayerRequestsListUI extends StatelessWidget {
  const PrayerRequestsListUI({super.key});

  @override
  Widget build(BuildContext context) {
    final requetePriereUiController =
        DiHelper.findOrCreate(creator: () => RequetePriereUiController())
        ..initAdminRequests();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(
            title: "Requêtes de prières",),
        Expanded(
          child: Obx(() {
            return CustomScrollView(
              slivers: [
                if (requetePriereUiController.adminRequests.isEmpty) ...[
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyWidget(
                      title: "Chargement en cours..",
                      iconData: TablerIcons.lasso_polygon,
                    ).paddingSymmetric(
                        horizontal: AppConstantsUtils.scaffoldHPadding),
                  ),
                ] else ...[
                  SliverToBoxAdapter(
                    child: Text(
                      "${requetePriereUiController.adminRequests.length} Requêtes de prières",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ).paddingSymmetric(
                      horizontal: AppConstantsUtils.scaffoldHPadding,
                      vertical: AppConstantsUtils.itemSpacing,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: AppConstantsUtils.itemSpacing,
                      left: AppConstantsUtils.scaffoldHPadding,
                      right: AppConstantsUtils.scaffoldHPadding,
                      bottom: AppConstantsUtils.scaffoldHeight(context) * 0.40,
                    ),
                    sliver: SliverList.separated(
                      itemCount: requetePriereUiController.adminRequests.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppConstantsUtils.itemSpacing),
                      itemBuilder: (context, index) {
                        final item =
                            requetePriereUiController.adminRequests[index];
                        return Container(
                          padding: const EdgeInsets.all(
                              AppConstantsUtils.itemSpacing),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius:
                                BorderRadius.circular(AppConstantsUtils.radius),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: AppConstantsUtils.itemSpacing,
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.jpg'),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          item.nomPrenom ?? "Anonyme",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // Text(
                                        //   TimeConfig.parseAnyDateFormatted(
                                        //       item.createdAt ?? ""),
                                        // ),
                                      ],
                                    ),
                                    Text(
                                      item.contenu ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  RoutesUtils.changePage(
                                    AppRoutes.prayerRequestDetails,
                                    arguments: {
                                      PrayerDatas.prayerRequestArg: item
                                    },
                                  );
                                },
                                child:
                                    Icon(TablerIcons.circle_arrow_right_filled),
                              ),
                              const SizedBox(
                                  width: AppConstantsUtils.itemSpacing),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ],
            );
          }),
        ),
      ],
    ).emptyScaffold;
  }
}
