import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_requete_priere.dart' show EntityRequetePriere;
import '../repositories/requete_priere_repository.dart' show RequetePriereRepository;

/// A concrete implementation of [GetRequetePriereByIdUseCase] with parameters.
///
/// This class requires a [RequetePriereRepository] to function.
/// It calls the repository method with the given parameters.
class GetRequetePriereByIdUseCase
    implements
        UseCase<EntityRequetePriere,
            GetRequetePriereByIdUseCaseParams> {
  /// Repository to interact with data layer.
  final RequetePriereRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetRequetePriereByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityRequetePriere?)> call(
      GetRequetePriereByIdUseCaseParams params) async {
    return await repository.getRequetePriereById(id: params.id);
  }
}

/// Parameter class for [GetRequetePriereByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetRequetePriereByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetRequetePriereByIdUseCaseParams].
  const GetRequetePriereByIdUseCaseParams({required this.id});
}
