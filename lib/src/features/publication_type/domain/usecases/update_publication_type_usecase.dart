import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_publication_type.dart' show EntityPublicationType;
import '../repositories/publication_type_repository.dart' show PublicationTypeRepository;

/// A concrete implementation of [UpdatePublicationTypeUseCase] with parameters.
///
/// This class requires a [PublicationTypeRepository] to function.
/// It calls the repository method with the given parameters.
class UpdatePublicationTypeUseCase implements UseCase<EntityPublicationType, UpdatePublicationTypeUseCaseParams> {

  /// Repository to interact with data layer.
  final PublicationTypeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdatePublicationTypeUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityPublicationType?)> call(UpdatePublicationTypeUseCaseParams params) async {
    return await repository.updatePublicationType(id: params.id, typePublication: params.typePublication);
  }
}

/// Parameter class for [UpdatePublicationTypeUseCaseParams].
///
/// Contains all the attributes required for the use case.
class UpdatePublicationTypeUseCaseParams {
  final int id;
  final String typePublication;
  /// Creates an instance of [UpdatePublicationTypeUseCaseParams].
  const UpdatePublicationTypeUseCaseParams({ required this.id, required this.typePublication});
}
