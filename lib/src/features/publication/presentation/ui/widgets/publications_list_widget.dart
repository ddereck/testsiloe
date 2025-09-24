import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../../../core/utils/routes_utils.dart' show RoutesUtils, AppRoutes;
import '../../../../../di/di_helper.dart' show DiHelper;
import '../../../../../utils/text_config.dart' show TextConfig;
import '../../../../article/adapters/article_datas.dart' show ArticleDatas;
import 'publication_content_card.dart' show PublicationContentCard;
import '../../adapters/publication_ui_controller.dart' show PublicationsUIController;

class PublicationsListWidget extends StatelessWidget {
  const PublicationsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final publicationsUiController =
        DiHelper.findOrCreate(creator: () => PublicationsUIController())
          ..initPublicationsIfNeeded();
    return Obx(() {
      return SliverPadding(
        padding: EdgeInsets.only(
          left: AppConstantsUtils.scaffoldHPadding,
          right: AppConstantsUtils.scaffoldHPadding,
          top: AppConstantsUtils.scaffoldHPadding,
          bottom: 24, // <-- Réduit le padding bas pour permettre le scroll complet
        ),
        sliver: publicationsUiController.filteredPublications.value.isEmpty
            ? SliverFillRemaining(
          child: Center(child: Text('Chargement des publications en cours...', style: TextConfig.getSimpleTextStyle(true))),
        ) :
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = publicationsUiController.filteredPublications.value[index];
              return InkWell(
                onTap: () {
                  RoutesUtils.changePage(AppRoutes.articleDetails,
                      arguments: {ArticleDatas.articleArg: item});
                },
                child: PublicationContentCard(publication: item),
              );
            },
            childCount: publicationsUiController.filteredPublications.value.length,
          ),
        ),
      );
    });
  }
}
