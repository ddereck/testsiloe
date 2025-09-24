import '../../../../core/errors/failure.dart';
import '../entities/entity_authentication.dart';
import '../repositories/authentication_repository.dart';

class SignInWithAppleUseCase {
  final AuthenticationRepository repository;
  const SignInWithAppleUseCase({required this.repository});

  Future<(Failure?, EntityAuthentication?)> call() async {
    return await repository.signInWithApple();
  }
}


