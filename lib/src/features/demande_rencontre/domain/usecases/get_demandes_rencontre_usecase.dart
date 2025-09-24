import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../repositories/demande_rencontre_repository.dart' show DemandeRencontreRepository;

/// A concrete implementation of [GetDemandesRencontreUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class GetDemandesRencontreUseCase
    implements UseCase<List<EntityDemandeRencontre>, GetDemandesRencontreUseCaseParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetDemandesRencontreUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityDemandeRencontre>)> call(
      GetDemandesRencontreUseCaseParams params) async {
    return await repository.getDemandes(
      statut: params.statut,
      utilisateurId: params.utilisateurId,
    );
  }
}

/// Parameter class for [GetDemandesRencontreUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetDemandesRencontreUseCaseParams {
  final String? statut;
  final int? utilisateurId;

  /// Creates an instance of [GetDemandesRencontreUseCaseParams].
  const GetDemandesRencontreUseCaseParams({
    this.statut,
    this.utilisateurId,
  });
}
