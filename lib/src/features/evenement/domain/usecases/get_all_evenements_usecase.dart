import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_evenement.dart' show EntityEvenement;
import '../repositories/evenement_repository.dart' show EvenementRepository;

/// A concrete implementation of [GetAllEvenementsUseCase] with parameters.
///
/// This class requires a [EvenementRepository] to function.
/// It calls the repository method with the given parameters.
class GetAllEvenementsUseCase
    implements UseCase<List<EntityEvenement>, GetAllEvenementsUseCaseParams> {
  /// Repository to interact with data layer.
  final EvenementRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetAllEvenementsUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityEvenement>)> call(
      GetAllEvenementsUseCaseParams params) async {
    return await repository.getAllEvenements(
      statut: params.statut,
      categorieId: params.categorieId,
      dateDebut: params.dateDebut,
      dateFin: params.dateFin,
    );
  }
}

/// Parameter class for [GetAllEvenementsUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetAllEvenementsUseCaseParams {
  final String? statut;
  final int? categorieId;
  final String? dateDebut;
  final String? dateFin;

  /// Creates an instance of [GetAllEvenementsUseCaseParams].
  const GetAllEvenementsUseCaseParams({
    this.statut,
    this.categorieId,
    this.dateDebut,
    this.dateFin,
  });
}
