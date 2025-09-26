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

class AdminDonationsListUI extends StatelessWidget {
  const AdminDonationsListUI({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final donsUiController =
        DiHelper.findOrCreate(creator: () => DonUIController())..initAdminDons();
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
                final map = donsUiController.montantsParMoisAdmin;
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
                if (donsUiController.adminDons.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyWidget(
                      title: "Aucun don",
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
                    itemCount: donsUiController.adminDons.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppConstantsUtils.itemSpacing),
                    itemBuilder: (context, index) {
                      final item = donsUiController.adminDons[index];
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
