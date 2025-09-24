import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../repositories/demande_rencontre_repository.dart'
    show DemandeRencontreRepository;

/// A concrete implementation of [AnnulerDemandeRencontreUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class AnnulerDemandeRencontreUseCase
    implements
        UseCase<EntityDemandeRencontre,
            AnnulerDemandeRencontreUseCaseParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const AnnulerDemandeRencontreUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityDemandeRencontre?)> call(
      AnnulerDemandeRencontreUseCaseParams params) async {
    return await repository.annulerDemande(id: params.id);
  }
}

/// Parameter class for [AnnulerDemandeRencontreUseCaseParams].
///
/// Contains all the attributes required for the use case.
class AnnulerDemandeRencontreUseCaseParams {
  final int id;

  /// Creates an instance of [AnnulerDemandeRencontreUseCaseParams].
  const AnnulerDemandeRencontreUseCaseParams({required this.id});
}
