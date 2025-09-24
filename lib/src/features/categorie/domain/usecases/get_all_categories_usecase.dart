import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_categorie.dart' show EntityCategorie;
import '../repositories/categorie_repository.dart' show CategorieRepository;

/// A concrete implementation of [GetAllCategoriesUseCase] with parameters.
///
/// This class requires a [CategorieRepository] to function.
/// It calls the repository method with the given parameters.
class GetAllCategoriesUseCase implements UseCase<List<EntityCategorie>, GetAllCategoriesUseCaseParams> {

  /// Repository to interact with data layer.
  final CategorieRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetAllCategoriesUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityCategorie>)> call(GetAllCategoriesUseCaseParams params) async {
    return await repository.getAllCategories(search: params.search, perPage: params.perPage);
  }
}

/// Parameter class for [GetAllCategoriesUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetAllCategoriesUseCaseParams {
  final int perPage;
  final String? search;
  /// Creates an instance of [GetAllCategoriesUseCaseParams].
  const GetAllCategoriesUseCaseParams({ this.perPage = 20, this.search});
}