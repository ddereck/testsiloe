import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/categorie_repository.dart' show CategorieRepository;

/// A concrete implementation of [DeleteCategorieUseCase] with parameters.
///
/// This class requires a [CategorieRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteCategorieUseCase implements UseCase<VoidType, DeleteCategorieUseCaseParams> {

  /// Repository to interact with data layer.
  final CategorieRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteCategorieUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(DeleteCategorieUseCaseParams params) async {
    return await repository.deleteCategorie(id: params.id);
  }
}

/// Parameter class for [DeleteCategorieUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeleteCategorieUseCaseParams {
  final int id;
  /// Creates an instance of [DeleteCategorieUseCaseParams].
  const DeleteCategorieUseCaseParams({ required this.id });
}
