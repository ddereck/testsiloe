import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_don.dart' show EntityDon;
import '../repositories/don_repository.dart' show DonRepository;

/// A concrete implementation of [CreateDonUseCase] with parameters.
///
/// This class requires a [DonRepository] to function.
/// It calls the repository method with the given parameters.
class CreateDonUseCase implements UseCase<EntityDon, CreateDonUseCaseParams> {
  /// Repository to interact with data layer.
  final DonRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateDonUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityDon?)> call(CreateDonUseCaseParams params) async {
    return await repository.createDon(
      nomAffiche: params.nomAffiche,
      montant: params.montant,
      reseau: params.reseau,
      anonyme: params.anonyme,
    );
  }
}

/// Parameter class for [CreateDonUseCaseParams].
///
/// Contains all the attributes required for the use case.
class CreateDonUseCaseParams {
  final String nomAffiche;
  final int montant;
  final String reseau;
  final bool anonyme;

  /// Creates an instance of [CreateDonUseCaseParams].
  const CreateDonUseCaseParams({
    required this.nomAffiche,
    required this.montant,
    required this.reseau,
    required this.anonyme,
  });
}
