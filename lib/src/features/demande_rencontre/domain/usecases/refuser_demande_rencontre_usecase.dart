import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../repositories/demande_rencontre_repository.dart'
    show DemandeRencontreRepository;

/// A concrete implementation of [RefuserDemandeRencontreUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class RefuserDemandeRencontreUseCase
    implements
        UseCase<EntityDemandeRencontre,
            RefuserDemandeRencontreUseCaseParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const RefuserDemandeRencontreUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityDemandeRencontre?)> call(
      RefuserDemandeRencontreUseCaseParams params) async {
    return await repository.refuserDemande(id: params.id);
  }
}

/// Parameter class for [RefuserDemandeRencontreUseCaseParams].
///
/// Contains all the attributes required for the use case.
class RefuserDemandeRencontreUseCaseParams {
  final int id;

  /// Creates an instance of [RefuserDemandeRencontreUseCaseParams].
  const RefuserDemandeRencontreUseCaseParams({required this.id});
}
