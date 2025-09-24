import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/don_repository.dart' show DonRepository;

/// A concrete implementation of [DeleteDonUseCase] with parameters.
///
/// This class requires a [DonRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteDonUseCase implements UseCase<VoidType, DeleteDonUseCaseParams> {
  /// Repository to interact with data layer.
  final DonRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteDonUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(DeleteDonUseCaseParams params) async {
    return await repository.deleteDon(id: params.id);
  }
}

/// Parameter class for [DeleteDonUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeleteDonUseCaseParams {
  final int id;

  /// Creates an instance of [DeleteDonUseCaseParams].
  const DeleteDonUseCaseParams({required this.id});
}
