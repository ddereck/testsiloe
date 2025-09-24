import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../repositories/demande_rencontre_repository.dart'
    show DemandeRencontreRepository;

/// A concrete implementation of [GetDemandeRencontreByIdUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class GetDemandeRencontreByIdUseCase
    implements
        UseCase<EntityDemandeRencontre,
            GetDemandeRencontreByIdUseCaseParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetDemandeRencontreByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityDemandeRencontre?)> call(
      GetDemandeRencontreByIdUseCaseParams params) async {
    return await repository.getDemandeById(id: params.id);
  }
}

/// Parameter class for [GetDemandeRencontreByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetDemandeRencontreByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetDemandeRencontreByIdUseCaseParams].
  const GetDemandeRencontreByIdUseCaseParams({required this.id});
}
