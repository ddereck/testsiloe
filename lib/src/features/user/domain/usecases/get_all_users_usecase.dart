import '../entities/entity_user.dart';
import '../repositories/user_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';


/// A concrete implementation of [GetAllUsersUseCase].
///
/// The constructor takes a [UserRepository] as a parameter.
/// The method [call] takes a [GetAllUsersUseCaseParams] as a parameter and returns a [Future] or [Stream]
/// depending on the value of [usecaseTypes[usecase]].
class GetAllUsersUseCase implements UseCase<List<EntityUser>, GetAllUsersUseCaseParams> {

  /// The constructor takes a [UserRepository] as a parameter.
  final UserRepository repository;
  const GetAllUsersUseCase({required this.repository});

  /// The method takes a [GetAllUsersUseCaseParams] as a parameter and returns a [Future] or [Stream]
  /// depending on the value of [usecaseTypes[usecase]].
  @override
  Future<(Failure?, List<EntityUser>)> call(GetAllUsersUseCaseParams params) async {
    return await repository.getAll(statut: params.statut, profil: params.profil, search: params.search);
  }
}

class GetAllUsersUseCaseParams {
  final String? statut;
  final String? profil;
  final String? search;
  const GetAllUsersUseCaseParams({this.statut, this.profil, this.search});
}