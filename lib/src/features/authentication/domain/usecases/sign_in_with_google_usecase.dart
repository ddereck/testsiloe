import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../entities/entity_authentication.dart';
import '../repositories/authentication_repository.dart';

class SignInWithGoogleUseCase {
  final AuthenticationRepository repository;
  const SignInWithGoogleUseCase({required this.repository});

  Future<(Failure?, EntityAuthentication?)> call(VoidType params) async {
    return await repository.signInWithGoogle();
  }
}
