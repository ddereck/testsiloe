import 'dart:io';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_evenement.dart' show EntityEvenement;
import '../repositories/evenement_repository.dart' show EvenementRepository;

/// A concrete implementation of [CreateEvenementUseCase] with parameters.
///
/// This class requires a [EvenementRepository] to function.
/// It calls the repository method with the given parameters.
class CreateEvenementUseCase
    implements UseCase<EntityEvenement, CreateEvenementUseCaseParams> {
  /// Repository to interact with data layer.
  final EvenementRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateEvenementUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityEvenement?)> call(
      CreateEvenementUseCaseParams params) async {
    return await repository.createEvenement(
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

/// Parameter class for [CreateEvenementUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreateEvenementUseCaseParams {
  final int categorieId;
  final int typePublicationId;
  final String theme;
  final String dateEvenement;
  final String? texteArticle;
  final int? placesLimitees;
  final String? dateFin;
  final String? lieu;
  final File? imageDeCouverture;

  /// Creates an instance of [CreateEvenementUseCaseParams].
  const CreateEvenementUseCaseParams({
    required this.categorieId,
    required this.typePublicationId,
    required this.theme,
    this.texteArticle,
    this.imageDeCouverture,
    required this.dateEvenement,
    this.dateFin,
    this.lieu,
    this.placesLimitees,
  });
}
