import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/requete_priere_repository.dart' show RequetePriereRepository;

/// A concrete implementation of [DeleteRequetePriereUseCase] with parameters.
///
/// This class requires a [RequetePriereRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteRequetePriereUseCase
    implements
        UseCase<VoidType,
            DeleteRequetePriereUseCaseParams> {
  /// Repository to interact with data layer.
  final RequetePriereRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteRequetePriereUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(
      DeleteRequetePriereUseCaseParams params) async {
    return await repository.deleteRequetePriere(id: params.id);
  }
}

/// Parameter class for [DeleteRequetePriereUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeleteRequetePriereUseCaseParams {
  final int id;

  /// Creates an instance of [DeleteRequetePriereUseCaseParams].
  const DeleteRequetePriereUseCaseParams({required this.id});
}
