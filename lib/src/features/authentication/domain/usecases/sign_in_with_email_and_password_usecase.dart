import '../entities/entity_authentication.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


import '../repositories/authentication_repository.dart';

/// A concrete implementation of [SignInWithEmailAndPasswordUseCase] with parameters.
///
/// This class requires a [AuthenticationRepository] to function.
/// It calls the repository method with the given parameters.
class SignInWithEmailAndPasswordUseCase implements UseCase<EntityAuthentication, SignInWithEmailAndPasswordUseCaseParams> {

  /// Repository to interact with data layer.
  final AuthenticationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const SignInWithEmailAndPasswordUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityAuthentication?)> call(SignInWithEmailAndPasswordUseCaseParams params) async {
    return await repository.signInWithEmailAndPassword(email: params.email, password: params.password);
  }
}

/// Parameter class for [SignInWithEmailAndPasswordUseCaseParams].
///
/// Contains all the attributes required for the use case.
class SignInWithEmailAndPasswordUseCaseParams {
  final String email;
  final String password;

  /// Creates an instance of [SignInWithEmailAndPasswordUseCaseParams].
    const SignInWithEmailAndPasswordUseCaseParams({ required this.email, required this.password });
}
