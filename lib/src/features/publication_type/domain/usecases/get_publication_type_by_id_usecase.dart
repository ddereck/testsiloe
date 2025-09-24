import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_publication_type.dart' show EntityPublicationType;
import '../repositories/publication_type_repository.dart' show PublicationTypeRepository;

/// A concrete implementation of [GetPublicationTypeByIdUseCase] with parameters.
///
/// This class requires a [PublicationTypeRepository] to function.
/// It calls the repository method with the given parameters.
class GetPublicationTypeByIdUseCase implements UseCase<EntityPublicationType, GetPublicationTypeByIdUseCaseParams> {

  /// Repository to interact with data layer.
  final PublicationTypeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetPublicationTypeByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityPublicationType?)> call(GetPublicationTypeByIdUseCaseParams params) async {
    return await repository.getPublicationTypeById(id: params.id);
  }
}

/// Parameter class for [GetPublicationTypeByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetPublicationTypeByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetPublicationTypeByIdUseCaseParams].
  const GetPublicationTypeByIdUseCaseParams({ required this.id });
}
