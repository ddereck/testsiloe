import '../entities/entity_authentication.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/authentication_repository.dart';

/// A concrete implementation of [SignUpWithEmailAndPasswordUseCase] with parameters.
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with the given parameters.
class SignUpWithEmailAndPasswordUseCase implements UseCase<EntityAuthentication, SignUpWithEmailAndPasswordUseCaseParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const SignUpWithEmailAndPasswordUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityAuthentication?)> call(SignUpWithEmailAndPasswordUseCaseParams params) async {
    return await repository.signUpWithEmailAndPassword(email: params.email, password: params.password);
  }
}

/// Parameter class for [SignUpWithEmailAndPasswordUseCaseParams].
///
/// Contains all the attributes required for the use case.
class SignUpWithEmailAndPasswordUseCaseParams {
  final String email;
  final String password;

  /// Creates an instance of [SignUpWithEmailAndPasswordUseCaseParams].
    const SignUpWithEmailAndPasswordUseCaseParams({ required this.email, required this.password });
}
