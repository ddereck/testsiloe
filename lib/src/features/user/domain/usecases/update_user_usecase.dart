import '../entities/entity_user.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/user_repository.dart';

/// A concrete implementation of [UpdateUserUseCase] with parameters.
///
/// This class requires a [UserRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateUserUseCase implements UseCase<EntityUser, UpdateUserUseCaseParams> {

  /// Repository to interact with data layer.
  final UserRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateUserUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityUser?)> call(UpdateUserUseCaseParams params) async {
    return await repository.updateUser(params.id, data: params.data);
  }
}

/// Parameter class for [UpdateUserUseCase].
///
/// Contains all the attributes required for the use case.
class UpdateUserUseCaseParams {
  final int id;
  final Map<String, dynamic> data;

  /// Creates an instance of [UpdateUserUseCaseParams].
    const UpdateUserUseCaseParams({ required this.id, required this.data });
}
