import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart'
    show TablerIcons;
import 'package:get/get.dart';
import 'package:siloe/src/di/controllers_provider.dart';

import '../../../../../core/configs/time_config.dart' show TimeConfig;
import '../../../../../core/utils/app_constants_utils.dart'
    show AppConstantsUtils;
import '../../../../../core/utils/routes_utils.dart'
    show RoutesUtils, AppRoutes;
import '../../../../../di/di_helper.dart' show DiHelper;
import '../../../../../utils/images_sources.dart' show ImagesSources;
import '../../../../../utils/text_config.dart' show TextConfig;
import '../../../domain/entities/entity_evenement.dart' show EntityEvenement;
import '../../adapters/evenement_ui_controller.dart' show EvenementUIController;
import '../../data/event_datas.dart' show EventDatas;

class EventWidget extends StatelessWidget {
  final EntityEvenement evenement;
  const EventWidget({super.key, required this.evenement});

  @override
  Widget build(BuildContext context) {
    final evenementUiController =
        DiHelper.findOrCreate(creator: () => EvenementUIController());
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: 100,
          child: Row(
            spacing: AppConstantsUtils.itemSpacing,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: evenement.imageDeCouverture != null
                    ? Image.network(
                        evenement.imageDeCouverture!,
                        width: 100,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        ImagesSources.image1,
                        width: 100,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (evenement.theme != null) ...[
                      Text(
                        evenement.theme ?? "",
                        style: TextConfig.getSimpleTextStyle(true),
                      ),
                    ],
                    if (evenement.lieu != null) ...[
                      Text(
                        evenement.lieu ?? "",
                        style: TextConfig.getSimpleTextStyle(false),
                      ),
                    ],
                    Text.rich(
                      TextSpan(
                        text: "",
                        style: TextConfig.getSimpleTextStyle(false,
                            size: AppConstantsUtils.smallSize),
                        children: [
                          if (evenement.dateEvenement != null) ...[
                            TextSpan(
                              text: TimeConfig.parseAnyDateFormatted(
                                  evenement.dateEvenement!),
                            ),
                          ],
                          if (evenement.dateFin != null) ...[
                            TextSpan(
                              text:
                                  " - ${TimeConfig.parseAnyDateFormatted(evenement.dateFin!)}",
                            ),
                          ],
                        ],
                      ),
                    ),
                    if(ControllersProvider.USER_CONTROLLER.userRole.value?.isAdminOrReverend ?? false) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: AppConstantsUtils.itemSpacing,
                        children: [
                          InkWell(
                            onTap: () {
                              RoutesUtils.changePage(AppRoutes.upsertEvent,
                                  arguments: {
                                    EventDatas.evenementArg: evenement
                                  });
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          InkWell(
                            onTap: () async => await evenementUiController
                                .deleteEvent(evenement: evenement),
                            child: Icon(
                              TablerIcons.trash,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ).paddingOnly(
                        right: AppConstantsUtils.containerHPadding,
                        bottom: AppConstantsUtils.containerHPadding,
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
