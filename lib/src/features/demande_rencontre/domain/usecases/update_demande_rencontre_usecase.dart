import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../repositories/demande_rencontre_repository.dart'
    show DemandeRencontreRepository;

/// A concrete implementation of [UpdateDemandeRencontreUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateDemandeRencontreUseCase
    implements
        UseCase<EntityDemandeRencontre, UpdateDemandeRencontreUseCaseParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateDemandeRencontreUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityDemandeRencontre?)> call(
      UpdateDemandeRencontreUseCaseParams params) async {
    return await repository.updateDemande(
      nomPrenoms: params.nomPrenoms,
      email: params.email,
      telephone: params.telephone,
      date: params.date,
      objet: params.objet,
      statut: params.statut,
      id: params.id,
    );
  }
}

/// Parameter class for [UpdateDemandeRencontreUseCaseParams].
///
/// Contains all the attributes required for the use case.
class UpdateDemandeRencontreUseCaseParams {
  final int id;
  final String? nomPrenoms;
  final String? email;
  final String? telephone;
  final String? date;
  final String? objet;
  final String? statut;

  /// Creates an instance of [UpdateDemandeRencontreUseCaseParams].
  const UpdateDemandeRencontreUseCaseParams({
    required this.id,
    this.nomPrenoms,
    this.email,
    this.telephone,
    this.date,
    this.objet,
    this.statut,
  });
}
