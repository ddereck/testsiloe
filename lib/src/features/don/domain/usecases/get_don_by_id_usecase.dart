import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_don.dart' show EntityDon;
import '../repositories/don_repository.dart' show DonRepository;

/// A concrete implementation of [GetDonByIdUseCase] with parameters.
///
/// This class requires a [DonRepository] to function.
/// It calls the repository method with the given parameters.
class GetDonByIdUseCase
    implements
        UseCase<EntityDon,
            GetDonByIdUseCaseParams> {
  /// Repository to interact with data layer.
  final DonRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetDonByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityDon?)> call(
      GetDonByIdUseCaseParams params) async {
    return await repository.getDonById(id: params.id);
  }
}

/// Parameter class for [GetDonByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetDonByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetDonByIdUseCaseParams].
  const GetDonByIdUseCaseParams({required this.id});
}
