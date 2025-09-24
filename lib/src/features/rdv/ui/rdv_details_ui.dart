import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/commons/extensions/scaffold_extension.dart';
import 'package:siloe/src/utils/text_config.dart';

import '../../../commons/ui/widgets/topbar_widget.dart';
import '../../../core/configs/time_config.dart' show TimeConfig;
import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../di/di_helper.dart' show DiHelper;
import '../adapters/rdv_ui_controller.dart' show RdvUIController;
import '../../demande_rencontre/domain/entities/entity_demande_rencontre.dart';

class RdvDetailsUI extends StatelessWidget {
  const RdvDetailsUI({super.key});

  @override
  Widget build(BuildContext context) {
    // L’argument passé lors de la navigation
    final EntityDemandeRencontre rdv =
        Get.arguments as EntityDemandeRencontre;

    // Controller
    final rdvController =
        DiHelper.findOrCreate(creator: () => RdvUIController());

    return Column(
      children: [
        const TopbarWidget(title: "Détail"),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: true,
                child: Obx(() {
                  final currentRdv = rdvController.rdvRequest.isNotEmpty
                      ? rdvController.rdvRequest.firstWhereOrNull(
                          (r) => r.id == rdv.id,
                        )
                      : rdv;

                  final isFinalized = currentRdv?.statut == "acceptee" ||
                      currentRdv?.statut == "refusee";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar + nom + tel
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/avatar.jpg'),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currentRdv?.nomPrenoms ?? "Anonyme",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        currentRdv?.telephone ?? "N/A",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Objet
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          "Objet de la demande",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        currentRdv?.objet ?? "",
                        style: TextConfig.getSimpleTextStyle(true),
                      ),

                      const SizedBox(height: 16),

                      // Date
                      if (currentRdv?.date != null)
                        Row(
                          children: [
                            const Icon(Icons.calendar_month,
                                color: Colors.black),
                            const SizedBox(width: 8),
                            const Text(
                              "Pointer pour : ",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              TimeConfig.formatDateFr(currentRdv?.date!),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                      const Spacer(),

                      // ✅ Boutons ou Badge selon le statut
                      if (!isFinalized)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: rdvController.isProcessing.value
                                    ? null
                                    : () async {
                                        await rdvController
                                            .confirmerRdv(rdv);
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                ),
                                child: const Text(
                                  "Confirmer",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: rdvController.isProcessing.value
                                    ? null
                                    : () async {
                                        await rdvController
                                            .annulerRdv(rdv);
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                ),
                                child: const Text(
                                  "Annuler",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: currentRdv?.statut == "acceptee"
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            currentRdv?.statut == "acceptee"
                                ? "Rendez-vous accepté"
                                : "Rendez-vous refusé",
                            style: TextStyle(
                              color: currentRdv?.statut == "acceptee"
                                  ? Colors.green.shade800
                                  : Colors.red.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ],
                  ).paddingSymmetric(
                    horizontal: AppConstantsUtils.scaffoldHPadding,
                    vertical: AppConstantsUtils.itemSpacing * 2,
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
