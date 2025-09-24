import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show NoParams;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../repositories/demande_rencontre_repository.dart' show DemandeRencontreRepository;

/// A concrete implementation of [GetMesDemandesRencontreUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class GetMesDemandesRencontreUseCase
    implements UseCase<List<EntityDemandeRencontre>, NoParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetMesDemandesRencontreUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityDemandeRencontre>)> call(
      NoParams params) async {
    return await repository.getMesDemandes();
  }
}