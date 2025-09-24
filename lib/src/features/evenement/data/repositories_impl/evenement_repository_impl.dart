import 'dart:io';

import 'package:siloe/src/core/resources/params.dart';

import '../../../../core/errors/failure.dart';

import '../../domain/entities/entity_evenement.dart';
import '../../domain/repositories/evenement_repository.dart';
import '../data_sources/evenement_data_source.dart';

/// A class that implements [EvenementRepository].
///
/// The class is named [EvenementRepositoryImpl] and contains
/// one method for each usecase in [usecases].
///
/// Each method has the same name as the usecase and takes as arguments the
/// attributes of the usecase. The return type of the method is [Future] or
/// [Stream] depending on the value of [usecaseTypes[usecase]].
class EvenementRepositoryImpl implements EvenementRepository {
  final EvenementDataSource dataSource;
  const EvenementRepositoryImpl(this.dataSource);

  @override
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
  }) async {
    try {
      final response = await dataSource.createEvenement(
        categorieId: categorieId,
        typePublicationId: typePublicationId,
        theme: theme,
        texteArticle: texteArticle,
        imageDeCouverture: imageDeCouverture,
        dateEvenement: dateEvenement,
        dateFin: dateFin,
        lieu: lieu,
        placesLimitees: placesLimitees,
      );
      return (null, response?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, VoidType?)> deleteEvenement({required int id}) async {
    try {
      await dataSource.deleteEvenement(id: id);
      return (null, VoidType());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, List<EntityEvenement>)> getAllEvenements({
    String? statut,
    int? categorieId,
    String? dateDebut,
    String? dateFin,
  }) async {
    try {
      final response = await dataSource.getAllEvenements(
        statut: statut,
        categorieId: categorieId,
        dateDebut: dateDebut,
        dateFin: dateFin,
      );
      return (
        null,
        response.map((e) => e.toEntity()).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(Failure?, EntityEvenement?)> getEvenementById(
      {required int id}) async {
    try {
      final response = await dataSource.getEvenementById(id: id);
      return (null, response?.toEntity());
    } catch (e) {
      rethrow;
    }
  }

  @override
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
  }) async {
    try {
      final response = await dataSource.updateEvenement(
        id: id,
        categorieId: categorieId,
        typePublicationId: typePublicationId,
        theme: theme,
        texteArticle: texteArticle,
        imageDeCouverture: imageDeCouverture,
        dateEvenement: dateEvenement,
        dateFin: dateFin,
        lieu: lieu,
        placesLimitees: placesLimitees,
      );
      return (
        null,
        response?.toEntity(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
