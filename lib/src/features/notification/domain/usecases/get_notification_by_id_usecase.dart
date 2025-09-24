import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_notification.dart' show EntityNotification;
import '../repositories/notification_repository.dart'
    show NotificationRepository;

/// A concrete implementation of [GetNotificationByIdUseCase] with parameters.
///
/// This class requires a [NotificationRepository] to function.
/// It calls the repository method with the given parameters.
class GetNotificationByIdUseCase
    implements UseCase<EntityNotification, GetNotificationByIdUseCaseParams> {
  /// Repository to interact with data layer.
  final NotificationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const GetNotificationByIdUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityNotification?)> call(
      GetNotificationByIdUseCaseParams params) async {
    return await repository.getNotificationById(id: params.id);
  }
}

/// Parameter class for [GetNotificationByIdUseCaseParams].
///
/// Contains all the attributes required for the use case.
class GetNotificationByIdUseCaseParams {
  final int id;

  /// Creates an instance of [GetNotificationByIdUseCaseParams].
  const GetNotificationByIdUseCaseParams({
    required this.id,
  });
}
