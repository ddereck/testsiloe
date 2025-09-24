import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/evenement_inscription_repository.dart' show EvenementInscriptionRepository;

/// A concrete implementation of [AnnulerInscriptionUseCase] with parameters.
///
/// This class requires a [EvenementInscriptionRepository] to function.
/// It calls the repository method with the given parameters.
class AnnulerInscriptionUseCase
    implements UseCase<VoidType, AnnulerInscriptionUseCaseParams> {
  /// Repository to interact with data layer.
  final EvenementInscriptionRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const AnnulerInscriptionUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(
      AnnulerInscriptionUseCaseParams params) async {
    return await repository.annulerInscription(
      evenementId: params.evenementId,
      inscriptionId: params.inscriptionId
    );
  }
}

/// Parameter class for [AnnulerInscriptionUseCaseParams].
///
/// Contains all the attributes required for the use case.
class AnnulerInscriptionUseCaseParams {
  final int inscriptionId;
  final int evenementId;

  /// Creates an instance of [AnnulerInscriptionUseCaseParams].
  const AnnulerInscriptionUseCaseParams({
    required this.evenementId,
    required this.inscriptionId,
  });
}
