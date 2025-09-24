import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_requete_priere.dart' show EntityRequetePriere;
import '../repositories/requete_priere_repository.dart'
    show RequetePriereRepository;

/// A concrete implementation of [CreateRequetePriereUseCase] with parameters.
///
/// This class requires a [RequetePriereRepository] to function.
/// It calls the repository method with the given parameters.
class CreateRequetePriereUseCase
    implements UseCase<EntityRequetePriere, CreateRequetePriereUseCaseParams> {
  /// Repository to interact with data layer.
  final RequetePriereRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateRequetePriereUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityRequetePriere?)> call(
      CreateRequetePriereUseCaseParams params) async {
    return await repository.createRequetePriere(
        nomPrenom: params.nomPrenom, contenu: params.contenu, anonyme: params.anonyme);
  }
}

/// Parameter class for [CreateRequetePriereUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreateRequetePriereUseCaseParams {
  final String nomPrenom;
  final String contenu;
  final bool anonyme;

  /// Creates an instance of [CreateRequetePriereUseCaseParams].
  const CreateRequetePriereUseCaseParams({
    required this.nomPrenom,
    required this.contenu,
    this.anonyme = true,
  });
}
