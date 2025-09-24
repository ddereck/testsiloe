import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_publication_type.dart' show EntityPublicationType;
import '../repositories/publication_type_repository.dart' show PublicationTypeRepository;

/// A concrete implementation of [CreatePublicationTypeUseCase] with parameters.
///
/// This class requires a [PublicationTypeRepository] to function.
/// It calls the repository method with the given parameters.
class CreatePublicationTypeUseCase implements UseCase<EntityPublicationType, CreatePublicationTypeUseCaseParams> {

  /// Repository to interact with data layer.
  final PublicationTypeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreatePublicationTypeUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityPublicationType?)> call(CreatePublicationTypeUseCaseParams params) async {
    return await repository.createPublicationType(typePublication: params.typePublication);
  }
}

/// Parameter class for [CreatePublicationTypeUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreatePublicationTypeUseCaseParams {
  final String typePublication;
  /// Creates an instance of [CreatePublicationTypeUseCaseParams].
  const CreatePublicationTypeUseCaseParams({ required this.typePublication });
}
