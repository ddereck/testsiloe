import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_commentaire.dart' show EntityCommentaire;
import '../repositories/commentaire_repository.dart' show CommentaireRepository;

/// A concrete implementation of GetCommentaireUseCase] with parameters.
///
/// This class requires a [CommentaireRepository] to function.
/// It calls the repository method with the given parameters.
class GetCommentairesUseCase
    implements UseCase< List<EntityCommentaire>, GetCommentairesUseCaseParams> {
  /// Repository to interact with data layer.
  final CommentaireRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetCommentairesUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityCommentaire>)> call(
    GetCommentairesUseCaseParams params) async {
    return await repository.getCommentaires(
      publicationId: params.publicationId,
    );
  }
}

/// Parameter class for GetCommentaireUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetCommentairesUseCaseParams {
  final int publicationId;

  /// Creates an instance of [GetCommentairesUseCaseParams].
  const GetCommentairesUseCaseParams({ required this.publicationId });
}
