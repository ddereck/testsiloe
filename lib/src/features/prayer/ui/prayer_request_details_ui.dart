import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/utils/text_config.dart';

import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../di/di_helper.dart' show DiHelper;
import '../adapters/prayer_ui_controller.dart' show PrayerUIController;
import '../../requete_priere/presentation/adapters/requete_priere_ui_controller.dart'
;

class PrayerRequestDetailsUI extends StatelessWidget {
  const PrayerRequestDetailsUI({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        DiHelper.findOrCreate(creator: () => PrayerUIController())
          ..initPrayerRequestByArgs();
    return Column(
      children: [
        TopbarWidget(title: "Details"),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: AppConstantsUtils.itemSpacingDualSide,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                      Text(controller.prayerRequest.value?.nomPrenom ?? 'Anonyme',
                          style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 16,)),
                      if(controller.prayerRequest.value?.statut != null)...[
                        Text(controller.prayerRequest.value?.statut ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 14,)),
                        const SizedBox(height: AppConstantsUtils.itemSpacing * 2),
                      ] ,
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          'Requête de prière',
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Text(
                        controller.prayerRequest.value?.contenu ?? '',
                        style: TextConfig.getSimpleTextStyle(true),
                      ),

                      // Boutons d’action
                      Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: (controller.prayerRequest.value?.statut == "publiee")
                                ? null
                                : () async {
                                    // TODO: action accusé réception
                                    final id = controller.prayerRequest.value?.id;
                                    if (id != null) {
                                      Get.find<RequetePriereUiController>().confirmerReception(id);
                                      controller.initPrayerRequestByArgs();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red,
                            ),
                            icon: const Icon(Icons.thumb_up),
                            label: const Text("J’accuse Reception"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            enabled: false, 
                            decoration: InputDecoration(
                              hintText: "Répondre",
                              prefixIcon: const Icon(Icons.reply),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          onSubmitted: (value) {
                            final id = controller.prayerRequest.value?.id;
                            if (id != null && value.isNotEmpty) {
                              //TODO
                              // Get.find<RequetePriereUiController>().repondreARequete(id, value);
                              // controller.responseController.clear();
                            }
                          },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ).paddingSymmetric(
                    horizontal: AppConstantsUtils.scaffoldHPadding,
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
