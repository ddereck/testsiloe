import '../entities/entity_user.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/user_repository.dart';

/// A concrete implementation of [GetUserByIdUseCase] with parameters.
///
/// This class requires a [UserRepository] to function.
/// It calls the repository method with the given parameters.
class GetUserByIdUseCase implements UseCase<EntityUser, GetUserByIdUseCaseParams> {

  /// Repository to interact with data layer.
  final UserRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetUserByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityUser?)> call(GetUserByIdUseCaseParams params) async {
    return await repository.getUserById(id: params.id);
  }
}

/// Parameter class for [GetUserByIdUseCase].
///
/// Contains all the attributes required for the use case.
class GetUserByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetUserByIdUseCaseParams].
  const GetUserByIdUseCaseParams({ required this.id });
}
