import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siloe/src/core/utils/routes_utils.dart';
import 'package:siloe/src/features/evenement/domain/entities/entity_evenement.dart';
import '../../../../commons/ui/widgets/custom_app_bar.dart';
import '../../../../di/di_helper.dart' show DiHelper;
import '../adapters/evenement_ui_controller.dart';
import 'widgets/event_card.dart';

class EvenementsPage extends StatelessWidget {
  const EvenementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final evenementUiController =
        DiHelper.findOrCreate(creator: () => EvenementUIController())
          ..initEvenements();

    return Scaffold(
      appBar: CustomAppBar(title: 'Évènements'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  RoutesUtils.changePage(AppRoutes.upsertEvent);
                },
                child: const Text('Ajouter'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (evenementUiController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (evenementUiController.evenements.value.isEmpty) {
                  return const Center(
                    child: Text("Aucun évènement pour le moment."),
                  );
                }
                return ListView.builder(
                  itemCount: evenementUiController.evenements.value.length,
                  itemBuilder: (context, index) {
                    final event = evenementUiController.evenements.value[index];
                    return EventCard(event: event);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  EventCard({required EntityEvenement event}) {}
}