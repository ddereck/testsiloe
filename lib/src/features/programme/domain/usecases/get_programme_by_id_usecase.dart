import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_programme.dart' show EntityProgramme;
import '../repositories/programme_repository.dart' show ProgrammeRepository;

/// A concrete implementation of [GetProgrammeByIdUseCase] with parameters.
///
/// This class requires a [ProgrammeRepository] to function.
/// It calls the repository method with the given parameters.
class GetProgrammeByIdUseCase implements UseCase<EntityProgramme, GetProgrammeByIdUseCaseParams> {

  /// Repository to interact with data layer.
  final ProgrammeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetProgrammeByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityProgramme?)> call(GetProgrammeByIdUseCaseParams params) async {
    return await repository.getProgrammeById(id: params.id);
  }
}

/// Parameter class for [GetProgrammeByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetProgrammeByIdUseCaseParams {
  final int id;
  /// Creates an instance of [GetProgrammeByIdUseCaseParams].
  const GetProgrammeByIdUseCaseParams({ required this.id });
}
