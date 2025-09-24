import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_requete_priere.dart' show EntityRequetePriere;
import '../repositories/requete_priere_repository.dart' show RequetePriereRepository;

/// A concrete implementation of [RejeterRequetePriereUseCase] with parameters.
///
/// This class requires a [RequetePriereRepository] to function.
/// It calls the repository method with the given parameters.
class RejeterRequetePriereUseCase
    implements
        UseCase<EntityRequetePriere,
            RejeterRequetePriereUseCaseParams> {
  /// Repository to interact with data layer.
  final RequetePriereRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const RejeterRequetePriereUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityRequetePriere?)> call(
      RejeterRequetePriereUseCaseParams params) async {
    return await repository.rejeterRequetePriere(id: params.id);
  }
}

/// Parameter class for [RejeterRequetePriereUseCaseParams].
///
/// Contains all the attributes required for the use case.
class RejeterRequetePriereUseCaseParams {
  final int id;

  /// Creates an instance of [RejeterRequetePriereUseCaseParams].
  const RejeterRequetePriereUseCaseParams({required this.id});
}
