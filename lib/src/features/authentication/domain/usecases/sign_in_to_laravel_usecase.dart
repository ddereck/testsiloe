import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../../../user/domain/entities/entity_user.dart' show EntityUser;
import '../repositories/authentication_repository.dart';

/// A concrete implementation of [SignInToLaravelUseCase] with parameters.
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with the given parameters.
class SignInToLaravelUseCase implements UseCase<EntityUser, SignInToLaravelUseCaseParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const SignInToLaravelUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityUser?)> call(SignInToLaravelUseCaseParams params) async {
    return await repository.signInToLaravel(firebaseToken: params.firebaseToken);
  }
}

/// Parameter class for [SignInToLaravelUseCaseParams].
///
/// Contains all the attributes required for the use case.
class SignInToLaravelUseCaseParams {
  final String? firebaseToken;

  /// Creates an instance of [SignInToLaravelUseCaseParams].
  const SignInToLaravelUseCaseParams({ required this.firebaseToken });
}
