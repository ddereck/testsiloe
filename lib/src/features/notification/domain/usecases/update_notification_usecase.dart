import '../../../../core/errors/failure.dart';
import '../../../../core/usecases_types/future_style_use_case_types.dart';
import '../entities/entity_notification.dart' show EntityNotification;
import '../repositories/notification_repository.dart'
    show NotificationRepository;

/// A concrete implementation of [UpdateNotificationUseCase] with parameters.
///
/// This class requires a [NotificationRepository] to function.
/// It calls the repository method with the given parameters.
class UpdateNotificationUseCase
    implements UseCase<EntityNotification, UpdateNotificationUseCaseParams> {
  /// Repository to interact with data layer.
  final NotificationRepository repository;

  /// Constructor for the use case, requiring a [repository].
  const UpdateNotificationUseCase({required this.repository});

  /// Calls the repository method with the given parameters.
  ///
  /// The method returns a [Future] or [Stream] based on the [usecaseType].
  @override
  Future<(Failure?, EntityNotification?)> call(
      UpdateNotificationUseCaseParams params) async {
    return await repository.updateNotification(
      id: params.id,
      titre: params.titre,
      message: params.message,
      type: params.type,
      lu: params.lu,
      data: params.data,
    );
  }
}

/// Parameter class for [UpdateNotificationUseCaseParams].
///
/// Contains all the attributes required for the use case.
class UpdateNotificationUseCaseParams {
  final int id;
  final String? titre;
  final String? message;
  final String? type;
  final bool? lu;
  final Map<String, dynamic>? data;

  /// Creates an instance of [UpdateNotificationUseCaseParams].
  const UpdateNotificationUseCaseParams({
    required this.id,
    this.titre,
    this.message,
    this.type,
    this.lu,
    this.data,
  });
}
