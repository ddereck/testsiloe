import 'dart:io';

import '../../../../core/errors/failure.dart';

import '../../../../core/resources/params.dart' show VoidType;
/// An abstract class that represents a repository for the feature [Evenement].
///
/// The class contains one abstract method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
///
/// The generated class is a valid implementation of
/// [EvenementRepository] and can be used as a
/// starting point for implementing the repository for the feature.

import '../entities/entity_evenement.dart';

abstract class EvenementRepository {
  Future<(Failure?, List<EntityEvenement>)> getAllEvenements({
    String? statut,
    int? categorieId,
    String? dateDebut,
    String? dateFin,
  });

  Future<(Failure?, EntityEvenement?)> getEvenementById({required int id});

  Future<(Failure?, EntityEvenement?)> createEvenement({
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

  Future<(Failure?, EntityEvenement?)> updateEvenement({
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

  Future<(Failure?, VoidType?)> deleteEvenement({required int id});
}
