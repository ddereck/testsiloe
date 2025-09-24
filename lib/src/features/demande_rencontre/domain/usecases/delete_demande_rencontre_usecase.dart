import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/demande_rencontre_repository.dart'
    show DemandeRencontreRepository;

/// A concrete implementation of [DeleteDemandeRencontreUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteDemandeRencontreUseCase
    implements
        UseCase<VoidType,
            DeleteDemandeRencontreUseCaseParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteDemandeRencontreUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(
      DeleteDemandeRencontreUseCaseParams params) async {
    return await repository.deleteDemande(id: params.id);
  }
}

/// Parameter class for [DeleteDemandeRencontreUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeleteDemandeRencontreUseCaseParams {
  final int id;

  /// Creates an instance of [DeleteDemandeRencontreUseCaseParams].
  const DeleteDemandeRencontreUseCaseParams({required this.id});
}
