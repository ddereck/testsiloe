import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/evenement_inscription_repository.dart' show EvenementInscriptionRepository;

/// A concrete implementation of [InscrireEvenementUseCase] with parameters.
///
/// This class requires a [EvenementInscriptionRepository] to function.
/// It calls the repository method with the given parameters.
class InscrireEvenementUseCase
    implements UseCase<VoidType, InscrireEvenementUseCaseParams> {
  /// Repository to interact with data layer.
  final EvenementInscriptionRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const InscrireEvenementUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(
      InscrireEvenementUseCaseParams params) async {
    return await repository.inscrireEvenement(
      params.evenementId, commentaire: params.commentaire
    );
  }
}

/// Parameter class for [InscrireEvenementUseCaseParams].
///
/// Contains all the attributes required for the use case.
class InscrireEvenementUseCaseParams {
  final String? commentaire;
  final int evenementId;

  /// Creates an instance of [InscrireEvenementUseCaseParams].
  const InscrireEvenementUseCaseParams({
    required this.evenementId,
    this.commentaire,
  });
}
