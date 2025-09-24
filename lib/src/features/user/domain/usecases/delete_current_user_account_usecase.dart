import '../../../../core/resources/params.dart' show VoidType;

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/user_repository.dart';

/// A concrete implementation of [DeleteCurrentUserAccountUseCase] with parameters.
///
/// This class requires a [UserRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteCurrentUserAccountUseCase implements UseCase<VoidType, DeleteCurrentUserAccountUseCaseParams> {

  /// Repository to interact with data layer.
  final UserRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteCurrentUserAccountUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(DeleteCurrentUserAccountUseCaseParams params) async {
    return await repository.deleteCurrentUserAccount(id: params.id);
  }
}

/// Parameter class for [DeleteCurrentUserAccountUseCase].
///
/// Contains all the attributes required for the use case.
class DeleteCurrentUserAccountUseCaseParams {
  final int id;

  /// Creates an instance of [DeleteCurrentUserAccountUseCaseParams].
    const DeleteCurrentUserAccountUseCaseParams({ required this.id });
}
