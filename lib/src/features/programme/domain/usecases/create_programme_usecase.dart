import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_programme.dart' show EntityProgramme;
import '../repositories/programme_repository.dart' show ProgrammeRepository;

/// A concrete implementation of [CreateProgrammeUseCase] with parameters.
///
/// This class requires a [ProgrammeRepository] to function.
/// It calls the repository method with the given parameters.
class CreateProgrammeUseCase
    implements UseCase<EntityProgramme, CreateProgrammeUseCaseParams> {
  /// Repository to interact with data layer.
  final ProgrammeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateProgrammeUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityProgramme?)> call(
      CreateProgrammeUseCaseParams params) async {
    return await repository.createProgramme(
      date: params.date,
      heure: params.heure,
      type: params.type,
      description: params.description,
      statut: params.statut,
    );
  }
}

/// Parameter class for [CreateProgrammeUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreateProgrammeUseCaseParams {
  final String date;
  final String heure;
  final String type;
  final String? description;
  final String? statut;
  /// Creates an instance of [CreateProgrammeUseCaseParams].
  const CreateProgrammeUseCaseParams({
  required this.date,
  required this.heure,
  required this.type,
  this.description,
  this.statut,
});
}
