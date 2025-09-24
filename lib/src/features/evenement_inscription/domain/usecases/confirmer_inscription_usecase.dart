import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/evenement_inscription_repository.dart' show EvenementInscriptionRepository;

/// A concrete implementation of [ConfirmerInscriptionUseCase] with parameters.
///
/// This class requires a [EvenementInscriptionRepository] to function.
/// It calls the repository method with the given parameters.
class ConfirmerInscriptionUseCase
    implements UseCase<VoidType, ConfirmerInscriptionUseCaseParams> {
  /// Repository to interact with data layer.
  final EvenementInscriptionRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const ConfirmerInscriptionUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(
      ConfirmerInscriptionUseCaseParams params) async {
    return await repository.confirmerInscription(
      evenementId: params.evenementId,
      inscriptionId: params.inscriptionId
    );
  }
}

/// Parameter class for [ConfirmerInscriptionUseCaseParams].
///
/// Contains all the attributes required for the use case.
class ConfirmerInscriptionUseCaseParams {
  final int inscriptionId;
  final int evenementId;

  /// Creates an instance of [ConfirmerInscriptionUseCaseParams].
  const ConfirmerInscriptionUseCaseParams({
    required this.evenementId,
    required this.inscriptionId,
  });
}
