import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show NoParams;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_don.dart' show EntityDon;
import '../repositories/don_repository.dart' show DonRepository;

/// A concrete implementation of [GetDonsHistoriquePublicUseCase] with parameters.
///
/// This class requires a [DonRepository] to function.
/// It calls the repository method with the given parameters.
class GetDonsHistoriquePublicUseCase
    implements UseCase<List<EntityDon>, NoParams> {
  /// Repository to interact with data layer.
  final DonRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetDonsHistoriquePublicUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, List<EntityDon>)> call(NoParams params) async {
    return await repository.getHistoriquePublic();
  }
}
