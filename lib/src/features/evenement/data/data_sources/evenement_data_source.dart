import 'dart:io' show File;

import '../models/model_evenement.dart';

abstract class EvenementDataSource {
    Future<List<ModelEvenement>> getAllEvenements({
        String? statut,
        int? categorieId,
        String? dateDebut,
        String? dateFin,
    });

    Future<ModelEvenement?> getEvenementById({required int id});

    Future<ModelEvenement?> createEvenement({
        required int categorieId,
        required int typePublicationId,
        required String theme,
        String? texteArticle,
        File? imageDeCouverture,
        required String dateEvenement,
        String? dateFin,
        String? lieu,
        int? placesLimitees,
    });

    Future<ModelEvenement?> updateEvenement({
        required int id,
        int? categorieId,
        int? typePublicationId,
        String? theme,
        String? texteArticle,
        File? imageDeCouverture,
        String? dateEvenement,
        String? dateFin,
        String? lieu,
        int? placesLimitees,
    });

    Future<void> deleteEvenement({required int id});
}
