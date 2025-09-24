import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_publication.dart' show EntityPublication;
import '../repositories/publication_repository.dart' show PublicationRepository;

/// A concrete implementation of [GetPublicationByIdUseCase] with parameters.
///
/// This class requires a [PublicationRepository] to function.
/// It calls the repository method with the given parameters.
class GetPublicationByIdUseCase implements UseCase<EntityPublication, GetPublicationByIdUseCaseParams> {

  /// Repository to interact with data layer.
  final PublicationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetPublicationByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityPublication?)> call(GetPublicationByIdUseCaseParams params) async {
    return await repository.getPublicationById(id: params.id);
  }
}

/// Parameter class for [GetPublicationByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetPublicationByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetPublicationByIdUseCaseParams].
  const GetPublicationByIdUseCaseParams({ required this.id });
}
