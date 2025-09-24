import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show NoParams;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_publication.dart' show EntityPublication;
import '../repositories/publication_repository.dart' show PublicationRepository;

/// A concrete implementation of [GetAllPublicationUseCase] with parameters.
///
/// This class requires a [PublicationRepository] to function.
/// It calls the repository method with the given parameters.
class GetAllPublicationUseCase implements UseCase<List<EntityPublication>, NoParams> {

  /// Repository to interact with data layer.
  final PublicationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetAllPublicationUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityPublication>)> call(NoParams params) async {
    return await repository.getAllPublications();
  }
}