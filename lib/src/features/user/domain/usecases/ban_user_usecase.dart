import '../entities/entity_user.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/user_repository.dart';

/// A concrete implementation of [BanUserUseCase] with parameters.
///
/// This class requires a [UserRepository] to function.
/// It calls the repository method with the given parameters.
class BanUserUseCase implements UseCase<EntityUser, BanUserUseCaseParams> {

  /// Repository to interact with data layer.
  final UserRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const BanUserUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityUser?)> call(BanUserUseCaseParams params) async {
    return await repository.banUser(id: params.id);
  }
}

/// Parameter class for [BanUserUseCase].
///
/// Contains all the attributes required for the use case.
class BanUserUseCaseParams {
  final int id;

  /// Creates an instance of [BanUserUseCaseParams].
    const BanUserUseCaseParams({ required this.id });
}
