import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_programme.dart' show EntityProgramme;
import '../repositories/programme_repository.dart' show ProgrammeRepository;

/// A concrete implementation of [GetProgrammesUseCase] with parameters.
///
/// This class requires a [ProgrammeRepository] to function.
/// It calls the repository method with the given parameters.
class GetProgrammesUseCase
    implements UseCase<List<EntityProgramme>, GetProgrammesUseCaseParams> {
  /// Repository to interact with data layer.
  final ProgrammeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetProgrammesUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityProgramme>)> call(
      GetProgrammesUseCaseParams params) async {
    return await repository.getProgrammes(
      statut: params.statut,
      type: params.type,
      dateDebut: params.dateDebut,
      dateFin: params.dateFin,
    );
  }
}

/// Parameter class for [GetProgrammesUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetProgrammesUseCaseParams {
  final String? statut;
  final String? type;
  final String? dateDebut;
  final String? dateFin;

  /// Creates an instance of [GetProgrammesUseCaseParams].
  const GetProgrammesUseCaseParams({
    this.statut,
    this.type,
    this.dateDebut,
    this.dateFin,
  });
}
