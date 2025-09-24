import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_programme.dart' show EntityProgramme;
import '../repositories/programme_repository.dart' show ProgrammeRepository;

/// A concrete implementation of [UpdateProgrammeUseCase] with parameters.
///
/// This class requires a [ProgrammeRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateProgrammeUseCase
    implements UseCase<EntityProgramme, UpdateProgrammeUseCaseParams> {
  /// Repository to interact with data layer.
  final ProgrammeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateProgrammeUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityProgramme?)> call(
      UpdateProgrammeUseCaseParams params) async {
    return await repository.updateProgramme(
      id: params.id,
      date: params.date,
      heure: params.heure,
      type: params.type,
      description: params.description,
      statut: params.statut,
    );
  }
}

/// Parameter class for [UpdateProgrammeUseCaseParams].
///
/// Contains all the attributes required for the use case.
class UpdateProgrammeUseCaseParams {
  final int id;
  final String? date;
  final String? heure;
  final String? type;
  final String? description;
  final String? statut;

  /// Creates an instance of [UpdateProgrammeUseCaseParams].
  const UpdateProgrammeUseCaseParams({
    required this.id,
    this.date,
    this.heure,
    this.type,
    this.description,
    this.statut,
  });
}
