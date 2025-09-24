import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_requete_priere.dart' show EntityRequetePriere;
import '../repositories/requete_priere_repository.dart'
    show RequetePriereRepository;

/// A concrete implementation of [UpdateRequetePriereUseCase] with parameters.
///
/// This class requires a [RequetePriereRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateRequetePriereUseCase
    implements UseCase<EntityRequetePriere, UpdateRequetePriereUseCaseParams> {
  /// Repository to interact with data layer.
  final RequetePriereRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateRequetePriereUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityRequetePriere?)> call(
      UpdateRequetePriereUseCaseParams params) async {
    return await repository.updateRequetePriere(id: params.id, nomPrenom: params.nomPrenom, contenu: params.contenu, 
    anonyme: params.anonyme, statut: params.statut);
  }
}

/// Parameter class for [UpdateRequetePriereUseCaseParams].
///
/// Contains all the attributes required for the use case.
class UpdateRequetePriereUseCaseParams {
  final int id;
  final String? nomPrenom;
  final String? contenu;
  final bool? anonyme;
  final String? statut;

  /// Creates an instance of [UpdateRequetePriereUseCaseParams].
  const UpdateRequetePriereUseCaseParams({
    required this.id,
    this.nomPrenom,
    this.contenu,
    this.anonyme,
    this.statut,
  });
}
