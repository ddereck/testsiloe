import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show NoParams;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_publication_type.dart' show EntityPublicationType;
import '../repositories/publication_type_repository.dart' show PublicationTypeRepository;

/// A concrete implementation of [GetAllPublicationTypeUseCase] with parameters.
///
/// This class requires a [PublicationTypeRepository] to function.
/// It calls the repository method with the given parameters.
class GetAllPublicationTypeUseCase implements UseCase<List<EntityPublicationType>, NoParams> {

  /// Repository to interact with data layer.
  final PublicationTypeRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetAllPublicationTypeUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityPublicationType>)> call(NoParams params) async {
    return await repository.getAllPublicationType();
  }
}