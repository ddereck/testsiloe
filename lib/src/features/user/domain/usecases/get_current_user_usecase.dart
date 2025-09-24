import '../entities/entity_user.dart';
import '../repositories/user_repository.dart';
import '../../../../core/resources/params.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


/// A concrete implementation of [GetCurrentUserUseCase].
///
/// The constructor takes a [UserRepository] as a parameter.
/// The method [call] takes a [NoParams] as a parameter and returns a [Future] or [Stream]
/// depending on the value of [usecaseTypes[usecase]].
class GetCurrentUserUseCase implements UseCase<EntityUser, NoParams> {

  /// The constructor takes a [UserRepository] as a parameter.
  final UserRepository repository;
  const GetCurrentUserUseCase({required this.repository});

  /// The method takes a [NoParams] as a parameter and returns a [Future] or [Stream]
  /// depending on the value of [usecaseTypes[usecase]].
  @override
  Future<(Failure?, EntityUser?)> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}

