import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_don.dart' show EntityDon;
import '../repositories/don_repository.dart' show DonRepository;

/// A concrete implementation of [GetDonsAdminUseCase] with parameters.
///
/// This class requires a [DonRepository] to function.
/// It calls the repository method with the given parameters.
class GetDonsAdminUseCase
    implements UseCase<List<EntityDon>, GetDonsAdminUseCaseParams> {
  /// Repository to interact with data layer.
  final DonRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetDonsAdminUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityDon>)> call(
      GetDonsAdminUseCaseParams params) async {
    return await repository.getDonsAdmin(
      reseau: params.reseau,
      anonyme: params.anonyme,
      utilisateurId: params.utilisateurId,
    );
  }
}

/// Parameter class for [GetDonsAdminUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetDonsAdminUseCaseParams {
  final String? reseau;
  final bool? anonyme;
  final int? utilisateurId;

  /// Creates an instance of [GetDonsAdminUseCaseParams].
  const GetDonsAdminUseCaseParams({
    String? status,
    this.reseau,
    this.anonyme,
    this.utilisateurId,
  });
}
