import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';

import '../../../commons/ui/widgets/empty_widget.dart';
import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../di/di_helper.dart' show DiHelper;
import '../../../utils/text_config.dart' show TextConfig;
import '../../don/presentation/adapters/don_ui_controller.dart'
    show DonUIController;
import 'widgets/donation_item_widget.dart' show DonationItemWidget;

class DonationsListUI extends StatelessWidget {
  const DonationsListUI({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final donsUiController =
        DiHelper.findOrCreate(creator: () => DonUIController())..initNtAdminDons();
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopbarWidget(
            title: "Dons"),
        Expanded(
          child: CustomScrollView(
            slivers: [
              Obx(() {
                final map = donsUiController.montantsParMoisNtAdmin;
                final sortedKeys = map.keys.toList()
                  ..sort((a, b) {
                    parse(String mois) =>
                        DateFormat("MMMM yyyy").parse(mois);
                    return parse(b).compareTo(parse(a)); // ordre descendant
                  });

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstantsUtils.scaffoldHPadding,
                      vertical: AppConstantsUtils.scaffoldHPadding,
                    ),
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      children: sortedKeys.map((mois) {
                        final montant = map[mois]!;
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                mois,
                                style: TextConfig.getSimpleTextStyle(true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${NumberFormat("#,###").format(montant)} FCFA',
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
              Obx(() {
                if (donsUiController.notAdminDons.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyWidget(
                      title: "Chargement..",
                      iconData: TablerIcons.lasso_polygon,
                    ).paddingSymmetric(
                        horizontal: AppConstantsUtils.scaffoldHPadding),
                  );
                }
                return SliverPadding(
                  padding: EdgeInsets.only(
                    top: AppConstantsUtils.itemSpacing * 2,
                    left: AppConstantsUtils.scaffoldHPadding,
                    right: AppConstantsUtils.scaffoldHPadding,
                    bottom: AppConstantsUtils.scaffoldHeight(context) * 0.40,
                  ),
                  sliver: SliverList.separated(
                    itemCount: donsUiController.notAdminDons.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppConstantsUtils.itemSpacing),
                    itemBuilder: (context, index) {
                      final item = donsUiController.notAdminDons[index];
                      return DonationItemWidget(don: item);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    ).emptyScaffold;
  }
}
