import 'dart:io';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_evenement.dart' show EntityEvenement;
import '../repositories/evenement_repository.dart' show EvenementRepository;

/// A concrete implementation of [UpdateEvenementUseCase] with parameters.
///
/// This class requires a [EvenementRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateEvenementUseCase
    implements UseCase<EntityEvenement, UpdateEvenementUseCaseParams> {
  /// Repository to interact with data layer.
  final EvenementRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateEvenementUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityEvenement?)> call(
      UpdateEvenementUseCaseParams params) async {
    return await repository.updateEvenement(
      id: params.id,
      categorieId: params.categorieId,
      typePublicationId: params.typePublicationId,
      theme: params.theme,
      texteArticle: params.texteArticle,
      imageDeCouverture: params.imageDeCouverture,
      dateEvenement: params.dateEvenement,
      dateFin: params.dateFin,
      lieu: params.lieu,
      placesLimitees: params.placesLimitees,
    );
  }
}

/// Parameter class for [UpdateEvenementUseCaseParams].
///
/// Contains all the attributes required for the use case.
class UpdateEvenementUseCaseParams {
  final int id;
  final int? categorieId;
  final int? typePublicationId;
  final String? theme;
  final String? dateEvenement;
  final String? texteArticle;
  final int? placesLimitees;
  final String? dateFin;
  final String? lieu;
  final File? imageDeCouverture;

  /// Creates an instance of [UpdateEvenementUseCaseParams].
  const UpdateEvenementUseCaseParams({
    required this.id,
    this.categorieId,
    this.typePublicationId,
    this.theme,
    this.texteArticle,
    this.imageDeCouverture,
    this.dateEvenement,
    this.dateFin,
    this.lieu,
    this.placesLimitees,
  });
}
