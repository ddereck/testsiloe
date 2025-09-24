import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/publication_type_repository.dart' show PublicationTypeRepository;

/// A concrete implementation of [DeletePublicationTypeUseCase] with parameters.
///
/// This class requires a [PublicationTypeRepository] to function.
/// It calls the repository method with the given parameters.
class DeletePublicationTypeUseCase implements UseCase<VoidType, DeletePublicationTypeUseCaseParams> {

  /// Repository to interact with data layer.
  final PublicationTypeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeletePublicationTypeUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(DeletePublicationTypeUseCaseParams params) async {
    return await repository.deletePublicationType(id: params.id);
  }
}

/// Parameter class for [DeletePublicationTypeUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeletePublicationTypeUseCaseParams {
  final int id;
  /// Creates an instance of [DeletePublicationTypeUseCaseParams].
  const DeletePublicationTypeUseCaseParams({ required this.id });
}
