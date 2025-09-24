import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/don_repository.dart' show DonRepository;

/// A concrete implementation of [FedapayCallbackUseCase] with parameters.
///
/// This class requires a [DonRepository] to function.
/// It calls the repository method with the given parameters.
class FedapayCallbackUseCase implements UseCase<VoidType, FedapayCallbackUseCaseParams> {
  /// Repository to interact with data layer.
  final DonRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const FedapayCallbackUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(FedapayCallbackUseCaseParams params) async {
    return await repository.fedapayCallback(
      transactionId: params.transactionId,
      status: params.status,
      montant: params.montant,
      donId: params.donId,
    );
  }
}

/// Parameter class for FedapayCallbacknUseCaseParams].
///
/// Contains all the attributes required for the use case.
class FedapayCallbackUseCaseParams {
  final String transactionId;
  final String status;
  final int montant;
  final int donId;

  /// Creates an instance of [FedapayCallbackUseCaseParams].
  const FedapayCallbackUseCaseParams({
    required this.transactionId,
    required this.status,
    required this.montant,
    required this.donId,
  });
}
