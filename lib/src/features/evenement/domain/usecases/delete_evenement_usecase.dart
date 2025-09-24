import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/evenement_repository.dart' show EvenementRepository;

/// A concrete implementation of [DeleteEvenementUseCase] with parameters.
///
/// This class requires a [EvenementRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteEvenementUseCase implements UseCase<VoidType, DeleteEvenementUseCaseParams> {

  /// Repository to interact with data layer.
  final EvenementRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteEvenementUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(DeleteEvenementUseCaseParams params) async {
    return await repository.deleteEvenement(id: params.id);
  }
}

/// Parameter class for [DeleteEvenementUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeleteEvenementUseCaseParams {
  final int id;
  /// Creates an instance of [DeleteEvenementUseCaseParams].
  const DeleteEvenementUseCaseParams({ required this.id });
}
