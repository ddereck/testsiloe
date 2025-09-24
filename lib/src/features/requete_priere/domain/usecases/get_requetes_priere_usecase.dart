import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_requete_priere.dart' show EntityRequetePriere;
import '../repositories/requete_priere_repository.dart' show RequetePriereRepository;

/// A concrete implementation of [GetRequetesPriereUseCase] with parameters.
///
/// This class requires a [RequetePriereRepository] to function.
/// It calls the repository method with the given parameters.
class GetRequetesPriereUseCase
    implements
        UseCase<List<EntityRequetePriere>,
            GetRequetesPriereUseCaseParams> {
  /// Repository to interact with data layer.
  final RequetePriereRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetRequetesPriereUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityRequetePriere>)> call(
      GetRequetesPriereUseCaseParams params) async {
    return await repository.getRequetesPriere(
        statut: params.statut, anonyme: params.anonyme);
  }
}

/// Parameter class for [GetRequetesPriereUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetRequetesPriereUseCaseParams {
  final String? statut;
  final bool? anonyme;

  /// Creates an instance of [GetRequetesPriereUseCaseParams].
  const GetRequetesPriereUseCaseParams({this.statut, this.anonyme});
}
