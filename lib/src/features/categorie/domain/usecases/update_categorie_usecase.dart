import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_categorie.dart' show EntityCategorie;
import '../repositories/categorie_repository.dart' show CategorieRepository;

/// A concrete implementation of [UpdateCategorieUseCase] with parameters.
///
/// This class requires a [CategorieRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateCategorieUseCase
    implements UseCase<EntityCategorie, UpdateCategorieUseCaseParams> {
  /// Repository to interact with data layer.
  final CategorieRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateCategorieUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityCategorie?)> call(
      UpdateCategorieUseCaseParams params) async {
    return await repository.updateCategorie(
      id: params.id,
      nomCategorie: params.nomCategorie,
    );
  }
}

/// Parameter class for [UpdateCategorieUseCaseParams].
///
/// Contains all the attributes required for the use case.
class UpdateCategorieUseCaseParams {
  final int id;
  final String nomCategorie;

  /// Creates an instance of [UpdateCategorieUseCaseParams].
  const UpdateCategorieUseCaseParams({
    required this.id,
    required this.nomCategorie,
  });
}
