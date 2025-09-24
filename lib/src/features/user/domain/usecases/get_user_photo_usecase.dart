import 'dart:io';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';

import '../repositories/user_repository.dart';

/// A concrete implementation of [UpdateUserPhotoUseCase] with parameters.
///
/// This class requires a [UserRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateUserPhotoUseCase implements UseCase<String, UpdateUserPhotoUseCaseParams> {

  /// Repository to interact with data layer.
  final UserRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateUserPhotoUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, String?)> call(UpdateUserPhotoUseCaseParams params) async {
    return await repository.updateUserPhoto(id: params.id, file: params.file);
  }
}

/// Parameter class for [UpdateUserPhotoUseCase].
///
/// Contains all the attributes required for the use case.
class UpdateUserPhotoUseCaseParams {
  final int id;
  final File file;
  /// Creates an instance of [UpdateUserPhotoUseCaseParams].
  const UpdateUserPhotoUseCaseParams({ required this.id, required this.file });
}
