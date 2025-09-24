import 'dart:io';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_commentaire.dart' show EntityCommentaire;
import '../repositories/commentaire_repository.dart' show CommentaireRepository;

/// A concrete implementation of [CreateCommentaireUseCase] with parameters.
///
/// This class requires a [CommentaireRepository] to function.
/// It calls the repository method with the given parameters.
class CreateCommentaireUseCase
    implements UseCase<EntityCommentaire, CreateCommentaireUseCaseParams> {
  /// Repository to interact with data layer.
  final CommentaireRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateCommentaireUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityCommentaire?)> call(
      CreateCommentaireUseCaseParams params) async {
    return await repository.createCommentaire(
      publicationId: params.publicationId,
      nom: params.nom,
      contenu: params.contenu,
      photo: params.photo,
    );
  }
}

/// Parameter class for [CreateCommentaireUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreateCommentaireUseCaseParams {
  final int publicationId;
  final String nom;
  final String contenu;
  final File? photo;

  /// Creates an instance of [CreateCommentaireUseCaseParams].
  const CreateCommentaireUseCaseParams({
    required this.publicationId,
    required this.nom,
    required this.contenu,
    this.photo,
  });
}
