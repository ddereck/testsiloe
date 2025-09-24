import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_categorie.dart' show EntityCategorie;
import '../repositories/categorie_repository.dart' show CategorieRepository;

/// A concrete implementation of [GetCategorieByIdUseCase] with parameters.
///
/// This class requires a [CategorieRepository] to function.
/// It calls the repository method with the given parameters.
class GetCategorieByIdUseCase implements UseCase<EntityCategorie, GetCategorieByIdUseCaseParams> {

  /// Repository to interact with data layer.
  final CategorieRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetCategorieByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityCategorie?)> call(GetCategorieByIdUseCaseParams params) async {
    return await repository.getCategorieById(id: params.id);
  }
}

/// Parameter class for [GetCategorieByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetCategorieByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetCategorieByIdUseCaseParams].
  const GetCategorieByIdUseCaseParams({ required this.id });
}
