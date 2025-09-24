import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/programme_repository.dart' show ProgrammeRepository;

/// A concrete implementation of [DeleteProgrammeUseCase] with parameters.
///
/// This class requires a [ProgrammeRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteProgrammeUseCase implements UseCase<VoidType, DeleteProgrammeUseCaseParams> {

  /// Repository to interact with data layer.
  final ProgrammeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteProgrammeUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(DeleteProgrammeUseCaseParams params) async {
    return await repository.deleteProgramme(id: params.id);
  }
}

/// Parameter class for [DeleteProgrammeUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeleteProgrammeUseCaseParams {
  final int id;
  /// Creates an instance of [DeleteProgrammeUseCaseParams].
  const DeleteProgrammeUseCaseParams({ required this.id });
}
