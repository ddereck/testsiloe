import '../entities/entity_user.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/user_repository.dart';

/// A concrete implementation of [UnbanUserUseCase] with parameters.
///
/// This class requires a [UserRepository] to function.
/// It calls the repository method with the given parameters.
class UnbanUserUseCase implements UseCase<EntityUser, UnbanUserUseCaseParams> {

  /// Repository to interact with data layer.
  final UserRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UnbanUserUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityUser?)> call(UnbanUserUseCaseParams params) async {
    return await repository.unbanUser(id: params.id);
  }
}

/// Parameter class for [UnbanUserUseCase].
///
/// Contains all the attributes required for the use case.
class UnbanUserUseCaseParams {
  final int id;

  /// Creates an instance of [UnbanUserUseCaseParams].
    const UnbanUserUseCaseParams({ required this.id });
}
