import '../entities/entity_user.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/user_repository.dart';

/// A concrete implementation of [CreateUserUseCase] with parameters.
///
/// This class requires a [UserRepository] to function.
/// It calls the repository method with the given parameters.
class CreateUserUseCase implements UseCase<EntityUser, CreateUserUseCaseParams> {

  /// Repository to interact with data layer.
  final UserRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const CreateUserUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityUser?)> call(CreateUserUseCaseParams params) async {
    return await repository.createUser(data: params.data);
  }
}

/// Parameter class for [CreateUserUseCase].
///
/// Contains all the attributes required for the use case.
class CreateUserUseCaseParams {
  final Map<String, dynamic> data;

  /// Creates an instance of [CreateUserUseCaseParams].
    const CreateUserUseCaseParams({ required this.data });
}
