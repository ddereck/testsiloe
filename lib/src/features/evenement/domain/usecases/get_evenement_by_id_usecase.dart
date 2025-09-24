import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_evenement.dart' show EntityEvenement;
import '../repositories/evenement_repository.dart' show EvenementRepository;

/// A concrete implementation of [GetEvenementByIdUseCase] with parameters.
///
/// This class requires a [EvenementRepository] to function.
/// It calls the repository method with the given parameters.
class GetEvenementByIdUseCase implements UseCase<EntityEvenement, GetEvenementByIdUseCaseParams> {

  /// Repository to interact with data layer.
  final EvenementRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetEvenementByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityEvenement?)> call(GetEvenementByIdUseCaseParams params) async {
    return await repository.getEvenementById(id: params.id);
  }
}

/// Parameter class for [GetEvenementByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetEvenementByIdUseCaseParams {
  final int id;
  /// Creates an instance of [GetEvenementByIdUseCaseParams].
  const GetEvenementByIdUseCaseParams({ required this.id });
}
