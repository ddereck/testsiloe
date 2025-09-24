import 'dart:io';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_publication.dart' show EntityPublication;
import '../repositories/publication_repository.dart' show PublicationRepository;

/// A concrete implementation of [CreatePublicationUseCase] with parameters.
///
/// This class requires a [PublicationRepository] to function.
/// It calls the repository method with the given parameters.
class CreatePublicationUseCase
    implements UseCase<EntityPublication, CreatePublicationUseCaseParams> {
  /// Repository to interact with data layer.
  final PublicationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreatePublicationUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityPublication?)> call(
      CreatePublicationUseCaseParams params) async {
    return await repository.createPublication(
      categorieId: params.categorieId,
      typePublicationId: params.typePublicationId,
      titre: params.titre,
      description: params.description,
      datePublication: params.datePublication,
      auteur: params.auteur,
      url: params.url,
      img: params.img,
      file: params.file,
      textArticle: params.textArticle,
    );
  }
}

/// Parameter class for [CreatePublicationUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreatePublicationUseCaseParams {
  final int categorieId;
  final int typePublicationId;
  final String titre;
  final String description;
  final String datePublication;
  final String auteur;
  final String? url;
  final File? img;
  final File? file;
  final String? textArticle;

  /// Creates an instance of [CreatePublicationUseCaseParams].
  const CreatePublicationUseCaseParams({
    required this.categorieId,
    required this.typePublicationId,
    required this.titre,
    required this.description,
    required this.datePublication,
    required this.auteur,
    this.url,
    this.img,
    this.file,
    this.textArticle,
  });
}
