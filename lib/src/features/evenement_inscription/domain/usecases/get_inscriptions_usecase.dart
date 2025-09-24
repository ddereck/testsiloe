import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_evenement_inscription.dart' show EntityEvenementInscription;
import '../repositories/evenement_inscription_repository.dart' show EvenementInscriptionRepository;

/// A concrete implementation of [GetInscriptionsUseCase] with parameters.
///
/// This class requires a [EvenementInscriptionRepository] to function.
/// It calls the repository method with the given parameters.
class GetInscriptionsUseCase
    implements UseCase<List<EntityEvenementInscription>, GetInscriptionsUseCaseParams> {
  /// Repository to interact with data layer.
  final EvenementInscriptionRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetInscriptionsUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityEvenementInscription>)> call(
      GetInscriptionsUseCaseParams params) async {
    return await repository.getInscriptions(
      evenementId: params.evenementId,
    );
  }
}

/// Parameter class for [GetInscriptionsUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetInscriptionsUseCaseParams {
  final int evenementId;

  /// Creates an instance of [GetInscriptionsUseCaseParams].
  const GetInscriptionsUseCaseParams({
    required this.evenementId,
  });
}
