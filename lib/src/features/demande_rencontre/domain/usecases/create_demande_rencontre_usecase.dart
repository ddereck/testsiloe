import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_demande_rencontre.dart' show EntityDemandeRencontre;
import '../repositories/demande_rencontre_repository.dart'
    show DemandeRencontreRepository;

/// A concrete implementation of [CreateDemandeRencontreUseCase] with parameters.
///
/// This class requires a [DemandeRencontreRepository] to function.
/// It calls the repository method with the given parameters.
class CreateDemandeRencontreUseCase
    implements
        UseCase<EntityDemandeRencontre,
            CreateDemandeRencontreUseCaseParams> {
  /// Repository to interact with data layer.
  final DemandeRencontreRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateDemandeRencontreUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityDemandeRencontre?)> call(
      CreateDemandeRencontreUseCaseParams params) async {
    return await repository.createDemandeRencontre(
      nomPrenoms: params.nomPrenoms,
      email: params.email,
      telephone: params.telephone,
      date: params.date,
      objet: params.objet,
    );
  }
}

/// Parameter class for [CreateDemandeRencontreUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreateDemandeRencontreUseCaseParams {
  final String nomPrenoms;
  final String email;
  final String telephone;
  final String date;
  final String objet;

  /// Creates an instance of [CreateDemandeRencontreUseCaseParams].
  const CreateDemandeRencontreUseCaseParams({
  required this.nomPrenoms,
  required this.email,
  required this.telephone,
  required this.date,
  required this.objet,
});
}
