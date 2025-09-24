import '../../../../core/errors/failure.dart';
import '../../../../core/resources/params.dart' show VoidType;
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../repositories/notification_repository.dart' show NotificationRepository;

/// A concrete implementation of [DeleteNotificationUseCase] with parameters.
///
/// This class requires a [NotificationRepository] to function.
/// It calls the repository method with the given parameters.
class DeleteNotificationUseCase implements UseCase<VoidType, DeleteNotificationUseCaseParams> {
  /// Repository to interact with data layer.
  final NotificationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const DeleteNotificationUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, VoidType?)> call(DeleteNotificationUseCaseParams params) async {
    return await repository.deleteNotification(id: params.id);
  }
}

/// Parameter class for [DeleteNotificationUseCaseParams].
///
/// Contains all the attributes required for the use case.
class DeleteNotificationUseCaseParams {
  final int id;

  /// Creates an instance of [DeleteNotificationUseCaseParams].
  const DeleteNotificationUseCaseParams({required this.id});
}
