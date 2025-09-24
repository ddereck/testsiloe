import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../commons/ui/widgets/custom_app_bar.dart';
import '../../../../core/configs/time_config.dart' show TimeConfig;
import '../../../../core/utils/app_constants_utils.dart'
    show AppConstantsUtils;
import '../../../../di/di_helper.dart' show DiHelper;
import '../adapters/evenement_ui_controller.dart'
    show EvenementUIController;
import '../../../../utils/text_config.dart' show TextConfig;

class EvenementsPage extends StatelessWidget {
  // ignore: use_super_parameters
  const EvenementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final evenementUiController =
        DiHelper.findOrCreate(creator: () => EvenementUIController())
          ..initEvenements();
    //
    final now = DateTime.now();

    //
    return Scaffold(
      appBar: CustomAppBar(title: 'Évènements'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstantsUtils.columnSpacingMedium,
          children: [
            // Programme de culte (en-tête avec image)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: ListTile(
                leading: Image.asset('assets/images/priere.png',
                    width: 70, height: 70, fit: BoxFit.cover),
                title: Text('Programme de culte',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            // Liste des évènements
            Obx(() {
              final evenementsPasses =
                  evenementUiController.evenements.value.where((e) {
                if (e.dateEvenement == null) return false;
                final date = DateTime.tryParse(e.dateEvenement!);
                return date != null && date.isBefore(now);
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(evenementsPasses.length, (index) {
                    final e = evenementsPasses[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 60,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF7A0C0C),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              TimeConfig.parseAnyDateFormatted(e.dateEvenement),
                              textAlign: TextAlign.center,
                              style: TextConfig.getSimpleTextStyle(false,
                                  color: Colors.white,
                                  size: AppConstantsUtils.tinySize),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 60,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 4)
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(e.theme ?? ''),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ],
              );
            }),
            // Évènement à venir
            Text('Évènements à venir',
                style: TextConfig.getSimpleTextStyle(true)),
            Obx(() {
              final evenementsAVenir =
                  evenementUiController.evenements.value.where((e) {
                if (e.dateEvenement == null) return false;
                final date = DateTime.tryParse(e.dateEvenement!);
                return date != null && date.isAfter(now);
              }).toList();

              if (evenementsAVenir.isEmpty) {
                return const Center(child: Text('Aucun événement à venir'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppConstantsUtils.columnSpacingMedium,
                children: [
                  ...List.generate(evenementsAVenir.length, (index) {
                    final item = evenementsAVenir[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4)
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 80,
                          height: 80,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: item.imageDeCouverture != null
                              ? Image.network(
                                  item.imageDeCouverture!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset('assets/images/priere.png',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover),
                        ),
                        title: Text(TimeConfig.parseAnyDateFormatted(
                            item.dateEvenement)),
                        subtitle: item.theme != null
                            ? Text(item.theme!,
                                style: TextConfig.getSimpleTextStyle(false))
                            : null,
                      ),
                    );
                  }),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
